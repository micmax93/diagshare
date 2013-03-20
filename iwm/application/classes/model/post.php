<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Post extends Model_Base
{
    public $_table_name = "post";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->ownerId);
    }

    public function myThread()
    {
        if($this->patientId!=null)
        {
            $p=new Model_Patient();
            return $p->getItem($this->patientId);
        }
        else if($this->tagId!=null)
        {
            $p=new Model_Tag();
            return $p->getItem($this->tagId);
        }
    }

    public function followingPosts()
    {
        return $this->myThread()->getAllPostsAfter($this->id);
    }
}

