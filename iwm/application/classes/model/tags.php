<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Tags extends Model_Base
{
    public $_table_name = "tags";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function getPhoto()
    {
        $p=new Model_Photos();
        return $p->getItem($this->photoID);
    }


    public function myPosts()
    {
        $p=new Model_Posts();
        return $p->newQuery()->where('tag_id','=',$this->id)->find_all();
    }

    public function getAllPostsAfter($lastPost)
    {
        $p=new Model_Posts();

        $p=$p->newQuery();
        $p=$p->where('tag_id','=',$this->id);
        $p=$p->where('id','>',$lastPost);
        $p=$p->order_by('id','ASC');

        return $p->find_all();
    }
}
