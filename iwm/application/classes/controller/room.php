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
        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($rooms));
    }

    public function action_load()
    {
        $widok = View::factory('editrooms');

       /* $id = $this->request->param('id');
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
       */
        $this->response->body($widok->render());
        WebSocketBroadcastAdmin::single_update('room', 0);
    }

}
