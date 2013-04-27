<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 24.03.13
 */

require("IwMController.php");
require("websocket.php");

class Controller_Room extends IwMController
{

    public function action_get()
    {
        $rooms = Model_Rooms::getStructTree();
        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($rooms));
    }

    public function action_load()
    {
        $widok = View::factory('editrooms');
        $mroom = new Model_Rooms();
        $rooms = $mroom->getAllItems();
        $widok->set('rooms',$rooms);
        $this->response->body($widok->render());

    }

    public function action_delete()
    {
        $id = $this->request->param('id');
        preg_replace('/[\s\W]+/', '-', $id);
        $mroom = new Model_Rooms();
        $mroom->deleteRoom($id);
        WebSocketBroadcastAdmin::single_update('room', 0);
    }

}
