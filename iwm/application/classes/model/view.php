<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_View extends Model_Base
{
    public $_table_name = "view";

    public function getPhoto()
    {
        $p=new Model_Photo();
        return $p->getItem($this->photoID);
    }

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->ownerId);
    }

    public function endY()
    {
        $photo=this.getPhoto();
        $myEnd=($this->y)+(($photo->height)/($this->scale));

        if($myEnd>($photo->height)) {return $photo->height;}
        else {return $myEnd;}
    }

    public function endX()
    {
        $photo=this.getPhoto();
        $myEnd=($this->x)+(($photo->width)/($this->scale));

        if($myEnd>($photo->width)) {return $photo->width;}
        else {return $myEnd;}
    }

    public function getVisibleTags()
    {
        $photo=this.getPhoto();
        $tags=$photo->myTags();
        $tags=$tags->where('x','>=',$this->x);
        $tags=$tags->where('x','<=',$this->endX());
        $tags=$tags->where('y','>=',$this->y);
        $tags=$tags->where('y','<=',$this->endY());

        return $tags->findAll();
    }
}
