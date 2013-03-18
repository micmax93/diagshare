<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Room extends Model_Base
{
    public $_table_name = "room";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->ownerId);
    }

    public function myPatients()
    {
        $p=new Model_Patient();
        return $p->where('roomId','=',$this->id);
    }
}