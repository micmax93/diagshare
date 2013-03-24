<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Posts extends Model_Base
{
    public $_table_name = "posts";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function getThread()
    {
        if($this->patient_id!=null)
        {
            $p=new Model_Patients();
            return $p->getItem($this->patient_id);
        }
        else if($this->tag_id!=null)
        {
            $p=new Model_Tags();
            return $p->getItem($this->tag_id);
        }
    }

    public function followingPosts()
    {
        return $this->getThread()->getAllPostsAfter($this->id);
    }
}

