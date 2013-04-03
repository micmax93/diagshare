 <?php
 
require_once("websocket.client.php");

class Controller_Thread
{
    // ------------------------------------------- Web socket client ---------------------------------------------------
    public $socket;

    public function __construct()
    {
        $this->socket = new WebSocket("ws://127.0.0.1:12345/echo/");
    }

    public function __destruct()
    {
        $this->socket->close();
    }

    public function broadcast($msg)
    {
        $ws_msg = WebSocketMessage::create($msg);
        $this->socket->sendMessage($ws_msg);
    }

    function ping()
    {
        $this->broadcast('ping');
    }


    // ------------------------------------------- Thread handling -----------------------------------------------------
    function newPost($user,$post)
    {

    }
}


        $ws=new Controller_Thread();
        $ws->broadcast("Witam");