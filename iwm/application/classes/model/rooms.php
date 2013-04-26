<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Rooms extends Model_Base
{
    public $_table_name = "rooms";

    public function getOwner()
    {
        $u = new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function myPatients()
    {
        $p = new Model_Patients();
        return $p->newQuery()->where('room_id', '=', $this->id)->find_all();
    }

    static public function getStructTree()
    {
        $rooms = (new Model_Rooms())->getAllItems();
        foreach ($rooms as $room) {
            $result[$room->name . '/' . $room->id] = "";
            $patients = $room->myPatients();
            foreach ($patients as $patient) {
                $result[$room->name . '/' . $room->id][$patient->name . '/' . $patient->id] = "";
                $photos = $patient->myPhotos();
                foreach ($photos as $photo) {
                    $result[$room->name . '/' . $room->id][$patient->name . '/' . $patient->id][$photo->title] = $photo->id;
                }
            }
        }
        return $result;
    }

    public function deleteRoom($id)
    {
        if (ORM::factory('rooms')->where('id', '=', $id)->count_all() > 0) {
            ORM::factory('rooms')->where('id', '=', $id)->find()->delete();
            return true;
        }
        return false;

    }

    public function setRoom($id, $arr)
    {
        if ($id != 0) {
            if (ORM::factory('rooms')->where('id', '=', $id)->count_all() == 0)
                return false;
            $p = ORM::factory('rooms')->where('id', '=', $id)->find();
        } else
            $p = ORM::factory('rooms');

        foreach ($arr as $k => $v) {
            $p->$k = $v;
        }

        $p->save();
        return true;
    }



}