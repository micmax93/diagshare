<?php
/**
 * Created by JetBrains PhpStorm.
 * User: phisikus
 * Date: 14.04.13
 * Time: 23:47
 * To change this template use File | Settings | File Templates.
 */

require("IwMController.php");
class Controller_Tag extends IwMController
{
    public function action_getAll()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $mtag = new Model_Tags();
        $tags = $mtag->getAllItemsForPhoto($id);
        $tags_arr = array();
        foreach ($tags as $tag) {
            $tags_arr[] = array(
                'id' => $tag->id,
                'photo_id' => $tag->photo_id,
                'owner_id' => $tag->owner_id,
                'title' => $tag->title,
                'x' => $tag->x,
                'y' => $tag->y,

            );

        }

        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($tags_arr));
    }

    public function action_get()
    {

        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $mtag = new Model_Tags();
        $t = $mtag->getItem($id);

        $tags_arr = array(
            'id' => $t->id,
            'photo_id' => $t->photo_id,
            'owner_id' => $t->owner_id,
            'title' => $t->title,
            'x' => $t->id,
            'y' => $t->id,

        );

        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($tags_arr));

    }


}