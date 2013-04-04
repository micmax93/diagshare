<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 03.04.13
 */
require("lib.websocket.php");

class Controller_Websocket
{
    public $socket;
    public $isOpen;

    public function __construct($addr="ws://127.0.0.1:12345/echo/")
    {
        $this->socket = new WebSocket($addr);
        $this->isOpen=true;

        try {
            $this->socket->open();
        }
        catch(Exception $exception)
        {
            //echo $exception->getMessage();
            $this->isOpen=false;
        }
    }

    public function __destruct()
    {
        if(!$this->isOpen) {return;}
        $this->socket->close();
    }

    public function sendMsg($msg)
    {
        if(!$this->isOpen) {return;}
        $ws_msg = WebSocketMessage::create($msg);
        $this->socket->sendMessage($ws_msg);
    }

    public function recvMsg()
    {
        if(!$this->isOpen) {return;}
        $msg = $this->socket->readMessage();
        return $msg->getData();
    }
}
