<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 24.03.13
 */

require("IwMController.php");
require("websocket.php");

class Controller_Chat extends IwMController
{
    public function action_tag()
    {
        $id=$_GET['id'];
        $last=$_GET['last'];

        $tag=(new Model_Tags())->getItem($id);
        $posts=$tag->getAllPostsAfter($last);
        $result= array();
        foreach($posts as $key => $val)
        {
            $tab['id']=$val->id;
            $tab['owner']=(new Model_Users())->getItem($val->owner_id)->name;
            $tab['content']=$val->content;
            array_push($result,$tab);
            unset($tab);
        }

        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($result));
    }
    public function action_update()
    {
        $type=$_GET['type'];
        $id=$_GET['id'];
        WebSocketBroadcastAdmin::single_update($type,$id);
//        $ws=new WebSocketBroadcastAdmin();
//        $ws->update($type,$id);
    }
}
