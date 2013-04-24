<?php
/**
 * Created by JetBrains PhpStorm.
 * User: phisikus
 * Date: 24.04.13
 * Time: 21:38
 * To change this template use File | Settings | File Templates.
 */

require("IwMController.php");
class Controller_Patient extends IwMController
{
    public function action_edit()
    {
        $widok = View::factory('editpatient');
        $room_id = Arr::get($_GET, 'room');
        if (!empty($room_id))
            $widok->set('room_id', $room_id);
        $this->response->body($widok->render());

    }

}