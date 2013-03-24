<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Patients extends Model_Base
{
    public $_table_name = "patients";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function getRoom()
    {
        $u=new Model_Rooms();
        return $u->getItem($this->room_id);
    }

    public function myPhotos()
    {
        $p=new Model_Photos();
        return $p->newQuery()->where('patient_id','=',$this->id)->find_all();
    }

    public function myPosts()
    {
        $p=new Model_Posts();
        return $p->newQuery()->where('patient_id','=',$this->id)->find_all();
    }

    public function getAllPostsAfter($lastPost)
    {
        $p=new Model_Posts();

        $p=$p->newQuery();
        $p=$p->where('patient_id','=',$this->id);
        $p=$p->where('id','>',$lastPost);
        $p=$p->order_by('id','ASC');

        return $p->find_all();
    }
}