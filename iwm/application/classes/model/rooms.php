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
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function myPatients()
    {
        $p=new Model_Patients();
        return $p->newQuery()->where('room_id','=',$this->id)->find_all();
    }

    static public function getStructTree()
    {
        $rooms=(new Model_Rooms())->getAllItems();
        foreach($rooms as $room)
        {
            $patients=$room->myPatients();
            foreach($patients as $patient)
            {
                $photos=$patient->myPhotos();
                foreach($photos as $photo)
                {
                    $result[$room->name][$patient->name][$photo->title]=$photo->id;
                }
            }
        }
        return $result;
    }
}