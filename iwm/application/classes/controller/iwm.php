<?php defined('SYSPATH') or die('No direct script access.');

require("IwMController.php");

class Controller_IwM extends IwMController
{

    public function action_index()
    {
        //  $image["DupaJAsio"] = URL::base().'application/views/img/xray.jpg';
        //  $image["xray2"] = URL::base().'application/views/img/xray2.jpg';

        $kanwa = View::factory('canvas');
        $rooms = View::factory('rooms');
        $chat = View::factory('chat');

        $widok = View::factory('index');
        $widok->set('title', 'DiagShare');
        $widok->set('canvas', $kanwa->render());
        $widok->set('room', $rooms->render());
        $widok->set('chat', $chat->render());

        $this->response->body($widok->render());
    }


} // End Welcome

