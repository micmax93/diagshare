#!/php -q
<?php
require_once("websocket.server.php");

class Manager
{
    public $user_list;
    public $resource_list;

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
    public function send_update($type,$id)
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

    public function say($msg) {
        echo '<CMD>' . "$msg \r\n";
    }
}



class SecureManager extends Manager
{
    function randString($len)
    {
        $str='';
        for($i=0;$i<$len;$i++)
        {
            $str= $str . chr(rand(40,120));
        }
        return $str;
    }
    function encodeString($str)
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

    public $admin_list;
    public function new_admin($uid,$uws)
    {
        $this->admin_list[$uid]['ws']=$uws;
        $str=$this->randString(16);
        $this->admin_list[$uid]['code']=$str;
        $this->admin_list[$uid]['hash']=$this->encodeString($str);
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
        if($this->is_admin($uid))
        {
            $this->remove_admin($uid);
        }
        else
        {
            parent::remove_user($uid);
        }
    }
    public function send_update($admin,$hash,$type,$id)
    {
        if($this->admin_list[$admin]['hash']==$hash)
        {
            parent::send_update($type,$id);
        }
    }
}


class BroadcastServer implements IWebSocketServerObserver {

    protected $debug = true;
    protected $server;

    public $master;
    public $manager;

    public function __construct() {
        $this->server = new WebSocketServer("tcp://0.0.0.0:12345", 'superdupersecretkey');
        $this->server->addObserver($this);

        $this->manager=new SecureManager();
    }

    public function onConnect(IWebSocketConnection $user) {
        $this->say("{$user->getId()} connected");
        //$this->users_set[$user->getId()]=$user;
    }

    function valid_struct($data)
    {
        return (isset($data->cmd) and isset($data->type) and isset($data->id));
    }

    public function onMessage(IWebSocketConnection $user, IWebSocketMessage $msg) {
        $this->say("{$user->getId()} says '{$msg->getData()}'");

        $data=json_decode($msg->getData());
        $sender=$user->getId();
        if(!$this->valid_struct($data)) {return;}

        if(!$this->manager->user_exists($sender))
        {
            if($data->cmd=='register')
            {
                if($data->type=='admin')
                {
                    $this->manager->new_admin($sender,$user);
                    $this->manager->send_verify($sender);
                }
                if($data->type=='user')
                {
                    $this->manager->new_user($sender,$user);
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
                        $this->manager->send_update($sender,$data->hash,$data->type,$data->id);
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

    public function onDisconnect(IWebSocketConnection $user) {
        $this->say("{$user->getId()} disconnected");
        $this->manager->remove_user($user->getId());
    }

    public function onAdminMessage(IWebSocketConnection $user, IWebSocketMessage $msg) {
        $frame = WebSocketFrame::create(WebSocketOpcode::PongFrame);
        $user->sendFrame($frame);
    }

    public function say($msg) {
        echo '<COM>' . "$msg \r\n";
    }

    public function run() {
        $this->server->run();
    }

}

//{"cmd":"request","type":"tag","id":3}
$server = new BroadcastServer();
$server->run();