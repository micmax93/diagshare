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
        $u = new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function getRoom()
    {
        $u = new Model_Rooms();
        return $u->getItem($this->room_id);
    }

    public function myPhotos()
    {
        $p = new Model_Photos();
        return $p->newQuery()->where('patient_id', '=', $this->id)->find_all();
    }

    public function myPosts()
    {
        $p = new Model_Posts();
        return $p->newQuery()->where('patient_id', '=', $this->id)->find_all();
    }

    public function getAllPostsAfter($lastPost)
    {
        $p = new Model_Posts();

        $p = $p->newQuery();
        $p = $p->where('patient_id', '=', $this->id);
        $p = $p->where('id', '>', $lastPost);
        $p = $p->order_by('id', 'ASC');

        return $p->find_all();
    }

    public function setPatient($arr)
    {
        if ($arr["id"] != 0) {
            if (ORM::factory('patients')->where('id', '=', $arr["id"])->count_all() == 0) return -1;
            $item = ORM::factory('patients')->where('id', '=', $arr["id"])->find();
        } else
            $item = ORM::factory('patients');
        foreach ($arr as $k => $v) {
            if ($k != "id")
                $item->$k = $v;
        }
        $item->save();
        return $item;

    }

    public function deletePatient($id)
    {
        if (ORM::factory('patients')->where('id', '=', $id)->count_all() > 0) {
            $patient = ORM::factory('patients')->where('id', '=', $id)->find();
            foreach ($patient->myPosts() as $post) $post->delete();
            foreach ($patient->myPhotos() as $photo) $photo->delete();
            return $patient->delete();

        }

        return false;
    }
}
