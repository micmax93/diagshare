<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 24.03.13
 */

require("IwMController.php");

class Controller_Room extends IwMController
{

    public function action_get()
    {
        $rooms = Model_Rooms::getStructTree();
        $this->response->header('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($rooms));
    }

}
