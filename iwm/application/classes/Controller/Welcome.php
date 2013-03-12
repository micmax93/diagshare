<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Welcome extends Controller
{

  public function action_index()
  {
    $widok = View::factory('index');
    $widok->set('tytul','Elorap');
    $widok->set('tresc','Lol');

    $this->response->body($widok->render());


    //$this->response->body('hello, world!');
  }


} // End Welcome
