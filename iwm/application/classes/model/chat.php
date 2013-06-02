<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Chat
{
    protected $chat_type = "tags";
    protected $chat_id = 0;

    public function __construct($type, $id)
    {
        $this->chat_type = $type;
        $this->chat_id = $id;
    }

    static public function getChat($res)
    {
        return new Model_Chat($res->_table_name, $res->id);
    }

    public function myPosts()
    {
        $p = new Model_Posts();
        $p = $p->newQuery();
        $p = $p->where('chat_type', '=', $this->chat_type);
        $p = $p->where('chat_id', '=', $this->chat_id);
        return $p->find_all();
    }

    public function getAllPostsAfter($lastPost)
    {
        $p = new Model_Posts();
        $p = $p->newQuery();
        $p = $p->where('chat_type', '=', $this->chat_type);
        $p = $p->where('chat_id', '=', $this->chat_id);
        $p = $p->where('id', '>', $lastPost);
        $p = $p->order_by('id', 'ASC');

        return $p->find_all();
    }

    public function getTitle()
    {
        if(class_exists('Model_'.ucfirst($this->chat_type)))
        {
            $res=ORM::factory($this->chat_type)->where("id","=",$this->chat_id)->find();

            if(isset($res->title))
            {
                return $res->title;
            }
            else if(isset($res->name))
            {
                return $res->name;
            }
        }
        return "$this->chat_type $this->chat_id";
    }
}