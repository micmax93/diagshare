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

    public function action_set()
    {

        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $post = $this->request->post();
        if (!empty($post['title'])) $tag["title"] = $post['title'];
        if (!empty($post['photo_id'])) $tag["photo_id"] = $post['photo_id'];
        if (!empty($post['owner_id'])) $tag["owner_id"] = $post['owner_id'];
        else
            $tag["owner_id"] = Auth::instance()->get_user()->id;
        if (!empty($post['x'])) $tag["x"] = $post['x'];
        if (!empty($post['y'])) $tag["y"] = $post['y'];

        $mtag = new Model_Tags();
        if (($id = $mtag->setTag($id, $tag["photo_id"],
            $tag["owner_id"],
            $tag["title"],
            $tag["x"],
            $tag["y"])) > 0
        )
            $res = array("id" => $id, "status" => "ok");
        else
            $res = array("status" => "failed");


        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($res));


    }

    public function action_delete()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $mtag = new Model_Tags();
        if ($mtag->deleteItem($id)) {
            $res = array("id" => $id, "status" => "ok");
        } else {
            $res = array("id" => $id, "status" => "failed");
        }

        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($res));


    }


}