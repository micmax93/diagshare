<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Patient extends Model_Base
{
    public $_table_name = "patient";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->ownerId);
    }

    public function getRoom()
    {
        $u=new Model_Room();
        return $u->getItem($this->roomId);
    }

    public function myPhotos()
    {
        $p=new Model_Photo();
        return $p->where('patientId','=',$this->id);
    }

    public function myPosts()
    {
        $p=new Model_Post();
        return $p->where('patientId','=',$this->id);
    }

    public function getAllPostsAfter($lastPost)
    {
        $p=new Model_Post();

        $p=$p->where('patientId','=',$this->id);
        $p=$p->where('id','>',$lastPost);
        $p=$p->order_by('id','ASC');

        return $p->find_all();
    }
}