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

    public function getVisibleTags()
    {
        //TODO
    }
}
