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

    public function action_index()
    {
        $type="tag";
        $id=3;
        if(isset($_POST['update']))
        {
            WebSocketBroadcastAdmin::single_update($_POST['type'],$_POST['id']);
            $type=$_POST['type'];
            $id=$_POST['id'];
        }
        echo '<h3>Admin site</h3>';
        echo '<form enctype="multipart/form-data" method="post">
                <input type="text" size="32" name="type" value="'.$type.'"><br>';
        echo '<input type="number" size="32" name="id" value="'.$id.'"><br>
                <input type="submit" name="update" value="update">
                </form>';

    }
}
