<?php
/**
 * Created by JetBrains PhpStorm.
 * User: phisikus
 * Date: 27.04.13
 * Time: 13:12
 * To change this template use File | Settings | File Templates.
 */
require("IwMController.php");
require("websocket.php");

class Controller_View extends IwMController
{
    public function action_load()
    {
        $widok = View::factory('editsessions');
        $mview = new Model_Views();
        $muser = new Model_User();
        $views = $mview->getAllItems();
        $users = Array();
        foreach ($views as $view) {
            $users[$view->owner_id] = $muser->getUser($view->owner_id)->username;
        }
        $widok->set('users', $users);
        $widok->set('views', $views);
        $this->response->body($widok->render());

    }

    public function action_set()
    {
        $id = $this->request->param('id');
        preg_replace('/[\s\W]+/', '-', $id);
        $arr["status"] = Arr::get($_POST, 'status');
        $arr["state"] = Arr::get($_POST, 'state');
        $arr["start"] = Arr::get($_POST, 'start');
        $arr["end"] = Arr::get($_POST, 'end');
        $arr["owner_id"] = Auth::instance()->get_user()->id;
        $mview = new Model_Views();

        if ($mview->setView($id, $arr)) {
            $this->response->body(json_encode(array("status" => "ok")));

        } else {
            $this->response->body(json_encode(array("status" => "fail")));
        }
    }

}