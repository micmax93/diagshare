#!/php -q
<?php

class Manager
{
    protected $user_list;
    protected $resource_list;

    function new_user($uid,$uws)
    {
        $this->user_list[$uid]['ws']=$uws;
        $this->user_list[$uid]['req']=array();
        $this->say("New user id=$uid");
    }
    public function request_resource($user,$type,$id)
    {
        $this->user_list[$user][$type][$id]=true;
        $this->resource_list[$type][$id][$user]=true;
        $this->say("User id=$user request resource $type($id)");
    }
    public function drop_resource($user,$type,$id)
    {
        unset($this->user_list[$user][$type][$id]);
        unset($this->resource_list[$type][$id][$user]);
        $this->say("User id=$user leaves resource $type($id)");
    }
    public function remove_user($uid)
    {
        foreach($this->user_list[$uid] as $type => $res)
        {
            foreach($res as $rid => $val)
            {
                unset($this->resource_list[$type][$rid][$uid]);
            }
        }
        unset($this->user_list[$uid]);
        $this->say("Removing user id=$uid");
    }
    public function user_exists($user)
    {
        return isset($this->user_list[$user]);
    }
    public function send_update($type,$id,$admin=null,$hash=null)
    {
        $n=0;
        if(isset($this->resource_list[$type][$id]))
        {
            $msg=new WebSocketMessage();
            $data['cmd']='update';
            $data['type']=$type;
            $data['id']=$id;
            $msg->setData(json_encode($data));

            foreach($this->resource_list[$type][$id] as $uid => $val)
            {
                $this->user_list[$uid]['ws']->sendMessage($msg);
                $n++;
            }
        }
        $this->say("Resource $type($id) update notify send to $n users");
    }

    protected function say($msg) {
        echo '<CMD>' . "$msg \r\n";
    }
}



class SecureManager extends Manager
{
    protected function rand_string($len)
    {
        $str='';
        for($i=0;$i<$len;$i++)
        {
            $str= $str . chr(rand(40,120));
        }
        return $str;
    }
    protected function encode_string($str)
    {
        $str2='';
        for($i=0;$i<strlen($str);$i++)
        {
            $ch=substr($str,$i,1);
            $str2= $str2 . $ch . chr(ord($ch)+((strlen($str)%($i+2))%5)-2);
        }
        $hash=crypt($str2,strrev($str));
        return $hash;
    }

    protected $admin_list;
    public function new_admin($uid,$uws)
    {
        $this->admin_list[$uid]['ws']=$uws;
        $str=$this->rand_string(16);
        $this->admin_list[$uid]['code']=$str;
        $this->admin_list[$uid]['hash']=$this->encode_string($str);
        $this->say("New admin id=$uid");
    }
    public function send_verify($uid)
    {
        $str=$this->admin_list[$uid]['code'];
        $msg=new WebSocketMessage();
        $msg->create($str);
        $msg->setData($str);
        $this->admin_list[$uid]['ws']->sendMessage($msg);
        $this->say("Verification code send to user id= $uid");
    }
    public function is_admin($uid)
    {
        return isset($this->admin_list[$uid]);
    }
    public function user_exists($user)
    {
        return (parent::user_exists($user) or $this->is_admin($user));
    }
    public function remove_admin($uid)
    {
        unset($this->admin_list[$uid]);
        $this->say("Removing admin id=$uid");
    }
    public function remove_user($uid)
    {
        if(!$this->user_exists($uid)) {return;}
        if($this->is_admin($uid))
        {
            $this->remove_admin($uid);
        }
        else
        {
            parent::remove_user($uid);
        }
    }
    public function send_update($type,$id,$admin=null,$hash=null)
    {
        if($this->admin_list[$admin]['hash']==$hash)
        {
            parent::send_update($type,$id);
        }
    }
}

class CommunicationInterpreter
{
    protected $chanel_list;
    protected $manager;

    public function __construct()
    {
        $this->manager=new SecureManager();
    }
    public function newChanel($chanelId,$socket)
    {
        $this->chanel_list[$chanelId]=$socket;
    }
    function isValidStruct($data)
    {
        return (isset($data->cmd) and isset($data->type) and isset($data->id));
    }
    public function messageReceived($sender,$msg)
    {
        $data=json_decode($msg);
        if(!$this->isValidStruct($data)) {return;}

        if(!$this->manager->user_exists($sender))
        {
            if($data->cmd=='register')
            {
                if($data->type=='admin')
                {
                    $this->manager->new_admin($sender,$this->chanel_list[$sender]);
                    $this->manager->send_verify($sender);
                }
                if($data->type=='user')
                {
                    $this->manager->new_user($sender,$this->chanel_list[$sender]);
                }
            }
        }
        else
        {
            if($this->manager->is_admin($sender))
            {
                if($data->cmd=='update')
                {
                    if(isset($data->hash))
                    {
                        $this->manager->send_update($data->type,$data->id,$sender,$data->hash);
                    }
                }
            }
            else
            {
                if($data->cmd=='request')
                {
                    $this->manager->request_resource($sender,$data->type,$data->id);
                }
                else if($data->cmd=='ignore')
                {
                    $this->manager->drop_resource($sender,$data->type,$data->id);
                }
            }
        }
    }
    public function chanelDisconnected($chanelId)
    {
        unset($this->chanel_list[$chanelId]);
        $this->manager->remove_user($chanelId);
    }
}

?>