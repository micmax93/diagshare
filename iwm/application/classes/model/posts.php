<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Posts extends Model_Base
{
    public $_table_name = "posts";

    public function getOwner()
    {
        $u=new Model_User();
        return $u->getItem($this->owner_id);
    }
}

