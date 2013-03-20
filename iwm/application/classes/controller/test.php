<?php defined('SYSPATH') or die('No direct script access.');

require("IwMController.php");

class Controller_Test extends IwMController
{

    public function action_index()
    {
        $x = new Model_User();
        $users= $x->getAllItems();
        echo $users[0]->name;
        return;

        $image["qwd"] = URL::base().'application/views/img/xray.jpg';
      //  $image["DupaJAsio"] = URL::base().'application/views/img/xray.jpg';
      //  $image["xray2"] = URL::base().'application/views/img/xray2.jpg';

        $kanwa = View::factory('canvas');
        $kanwa->set('images',$image);
        $rooms = View::factory('rooms');
        $chat = View::factory('chat');

        $widok = View::factory('index');
        $widok->set('title', 'DiagShare');
        $widok->set('canvas',$kanwa->render());
        $widok->set('room',$rooms->render());
        $widok->set('chat',$chat->render());

        $this->response->body($widok->render());
    }


    public function action_testing()
    {

    }


} // End Welcome

