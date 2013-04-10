<?php
/**
 * Created by Yongo Group
 * User: phisikus
 * Date: 26.03.13
 * Time: 13:16
 */

require("IwMController.php");

class Controller_Image extends IwMController
{


    public function action_get()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $photos = new Model_Photos();
        $image = $photos->getItem($id)->getLinkArray();
        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($image));
    }

}
