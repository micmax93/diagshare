<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Views extends Model_Base
{
    public $_table_name = "views";

    public function getPhoto()
    {
        $p=new Model_Photos();
        return $p->getItem($this->photo_id);
    }

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function endY()
    {
        $photo=$this->getPhoto();
        $myEnd=($this->y)+(($photo->height)/($this->scale));

        if($myEnd>($photo->height)) {return $photo->height;}
        else {return $myEnd;}
    }

    public function endX()
    {
        $photo=$this->getPhoto();
        $myEnd=($this->x)+(($photo->width)/($this->scale));

        if($myEnd>($photo->width)) {return $photo->width;}
        else {return $myEnd;}
    }

    public function getVisibleTags()
    {
        $photo=$this->getPhoto();
        $tags=$photo->getTags($this->x,$this->y,$this->endX(),$this->endY());
        return $tags;
    }
}
