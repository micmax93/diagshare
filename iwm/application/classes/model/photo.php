<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Photo extends Model_Base
{
    public $_table_name = "photo";

    public function getPatient()
    {
        $p=new Model_Patient();
        return $p->getItem($this->patientID);
    }

    public function myViews()
    {
        $p=new Model_View();
        return $p->where('photoId','=',$this->id);
    }

    public function myTags()
    {
        $p=new Model_Tag();
        return $p->where('photoId','=',$this->id);
    }
}