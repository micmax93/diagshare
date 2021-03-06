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
    public function action_get()
    {
        $id = $_POST['id'];
        $last = $_POST['last'];
        $type = $_POST['type'];

        $chat = new Model_Chat($type,$id);
        $posts = $chat->getAllPostsAfter($last);

        $result['type'] = $type;
        $result['id'] = $id;
        $result['title'] = $chat->getTitle();
        $result['posts'] = array();
        foreach ($posts as $key => $val) {
            $tab['id'] = $val->id;
            $tab['owner'] = (new Model_User())->getUser($val->owner_id)->username;
            $tab['content'] = $val->content;
            array_push($result['posts'], $tab);
            unset($tab);
        }

        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($result));
    }

    public function action_update()
    {
        $type = $_GET['type'];
        $id = $_GET['id'];
        WebSocketBroadcastAdmin::single_update($type, $id);
//        $ws=new WebSocketBroadcastAdmin();
//        $ws->update($type,$id);
    }

    public function action_newpost()
    {
        $type = $_POST['type'];
        $id = $_POST['id'];
        $content = $_POST['content'];

        $new_post = new Model_Posts();
        $new_post->chat_id = $id;
        $new_post->chat_type = $type;
        $new_post->content = $content;
        $new_post->owner_id = Auth::instance()->get_user()->id;
        $new_post->save();

        WebSocketBroadcastAdmin::single_update($type, $id);
    }

    public function action_live()
    {
        $chanel = Auth::instance()->get_user()->id;

        $result['chanel'] = $chanel;
        $result['hash'] = crypt("user=" . $chanel,"live_view");

        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($result));
    }

    public function action_index()
    {
        $type = "tags";
        $id = 3;
        if (isset($_POST['update'])) {
            WebSocketBroadcastAdmin::single_update($_POST['type'], $_POST['id']);
            $type = $_POST['type'];
            $id = $_POST['id'];
        }
        if (isset($_POST['newpost'])) {
            $this->action_newpost();
        }
        if (isset($_POST['download'])) {
            $this->action_get();
            return;
        }
        echo '<h3>Admin site</h3>';
        echo '<form enctype="multipart/form-data" method="post">
                <input type="text" size="32" name="type" value="' . $type . '"><br>';
        echo '<input type="number" size="32" name="id" value="' . $id . '"><br>
                <input type="submit" name="update" value="update">
                </form>';

        echo '<hr>';
        echo '<h3>Post generator</h3>';
        echo '<form enctype="multipart/form-data" method="post">
                <input type="text" size="32" name="content" placeholder="tresc postu" value=""><br>
                <input type="text" size="32" name="type" value="tag"><br>
                <input type="number" size="32" name="id" value="3"><br>
                <input type="submit" name="newpost" value="newpost">
                </form>';

        echo '<hr>';
        echo '<h3>Post downloader</h3>';
        echo '<form enctype="multipart/form-data" method="post">
                <input type="number" size="32" name="id" value="115"><br>
                <input type="number" size="32" name="last" value="0"><br>
                <input type="text" size="32" name="type" value="tags"><br>
                <input type="submit" name="download" value="download">
                </form>';

    }
}
