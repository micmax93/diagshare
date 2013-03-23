<?php defined('SYSPATH') or die('No direct script access.');

require("IwMController.php");

class Controller_Test extends IwMController
{

    public function action_index()
    {
        $image["Zestaw1"] = array(
            "rowSize" => "3",
            "numberOfRows" => "3",
            "images" =>
            array(
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
                url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
            )

        );


        $image["Obraz1"] = array(
            "rowSize" => "1",
            "numberOfRows" => "1",
            "images" => array(url::base(TRUE, 'http') . 'application/views/img/xray.jpg')
        );

        $imageSettings["scale"] = 1;
        //  $image["DupaJAsio"] = URL::base().'application/views/img/xray.jpg';
        //  $image["xray2"] = URL::base().'application/views/img/xray2.jpg';

        $kanwa = View::factory('canvas');
        $kanwa->set('images', $image);
        $kanwa->set('imageSettings', $imageSettings);

        $rooms = View::factory('rooms');
        $chat = View::factory('chat');

        $widok = View::factory('index');
        $widok->set('title', 'DiagShare');
        $widok->set('canvas', $kanwa->render());
        $widok->set('room', $rooms->render());
        $widok->set('chat', $chat->render());

        $this->response->body($widok->render());
    }


    public function action_testing()
    {

    }


} // End Welcome

