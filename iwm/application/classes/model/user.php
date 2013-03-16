<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 16.03.13
 */

class Model_User extends ORM
{
    public $_table_name = "user";

    public function getUser($id)
    {
       return ORM::factory('user')->where('id','=',$id)->find();
    }
    public function getAllUsers()
    {
        return ORM::factory('user')->find_all();
    }
}

