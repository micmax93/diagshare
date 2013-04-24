<?php
/**
 * Created by JetBrains PhpStorm.
 * User: phisikus
 * Date: 24.04.13
 * Time: 21:38
 * To change this template use File | Settings | File Templates.
 */

require("IwMController.php");
require("websocket.php");
class Controller_Patient extends IwMController
{
    public function action_edit()
    {
        $widok = View::factory('editpatient');
        $mpatient = new Model_Patients();

        $id = $this->request->param('id');
        preg_replace('/[\s\W]+/', '-', $id);
        $widok->set('id', $id);

        if (isset($_POST['name'])) {
            if (!empty($id))
                $arr["id"] = $id;
            else
                $arr["id"] = 0;

            $arr["name"] = $_POST['name'];
            $arr["room_id"] = $_POST['room_id'];
            if (strlen($arr["name"]) == 0) $arr["name"] = "Empty Name";

            $mpatient->setPatient($arr);
            $widok->set('saved', 1);
            $widok->set('message', '
                <script type="text/javascript">
                    window.close();
                </script>
                ');
            $widok->set('id', $id);


        } else {
            if ($id != 0) {
                $patient = $mpatient->getItem($id);
                $widok->set('name', $patient->name);
                $widok->set('room_id', $patient->room_id);
            } else {
                $widok->set('room_id', Arr::get($_GET, 'room'));
            }
        }
        $this->response->body($widok->render());
        WebSocketBroadcastAdmin::single_update('room', 0);

    }


    public function action_delete()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);
        $mpatient = new Model_Patients();

        if ($mpatient->deletePatient($id)) {
            $res = array("status" => "ok");
            WebSocketBroadcastAdmin::single_update('room', 0);
        } else {
            $res = array("status" => "failed");
        }

        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($res));
    }





}