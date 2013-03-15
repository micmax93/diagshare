<?php defined('SYSPATH') or die('No direct script access.');

require("IwMController.php");

class Controller_Test extends IwMController
{

    public function action_index()
    {
        $widok = View::factory('index');
        $widok->set('tytul', 'Elorap');
        $widok->set('tresc', 'Lol');

        $this->response->body($widok->render());


        $this->response->body('hello, world!');
    }


} // End Welcome
