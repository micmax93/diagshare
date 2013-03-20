<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Tag extends Model_Base
{
    public $_table_name = "tag";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->ownerId);
    }

    public function getPhoto()
    {
        $p=new Model_Photo();
        return $p->getItem($this->photoID);
    }


    public function myPosts()
    {
        $p=new Model_Post();
        return $p->where('tagId','=',$this->id);
    }

    public function getAllPostsAfter($lastPost)
    {
        $p=new Model_Post();

        $p=$p->where('tagId','=',$this->id);
        $p=$p->where('id','>',$lastPost);
        $p=$p->order_by('id','ASC');

        return $p->find_all();
    }
}
