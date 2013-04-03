#!/php -q
<?php
require_once("websocket.server.php");


class DemoSocketServer implements IWebSocketServerObserver {

    protected $debug = true;
    protected $server;
    public $users_set;

    public function __construct() {
        $this->server = new WebSocketServer("tcp://0.0.0.0:12345", 'superdupersecretkey');
        $this->server->addObserver($this);
    }

    public function onConnect(IWebSocketConnection $user) {
        $this->say("{$user->getId()} connected");
        $this->users_set[$user->getId()]=$user;
    }

    public function onMessage(IWebSocketConnection $user, IWebSocketMessage $msg) {
        $this->say("{$user->getId()} says '{$msg->getData()}'");

        foreach($this->users_set as $id => $u)
        {
            if($id!=$user->getId())
            {$u->sendMessage($msg);}
        }
    }

    public function onDisconnect(IWebSocketConnection $user) {
        $this->say("{$user->getId()} disconnected");
        unset($this->users_set[$user->getId()]);
    }

    public function onAdminMessage(IWebSocketConnection $user, IWebSocketMessage $msg) {
        $frame = WebSocketFrame::create(WebSocketOpcode::PongFrame);
        $user->sendFrame($frame);
    }

    public function say($msg) {
        echo "$msg \r\n";
    }

    public function run() {
        $this->server->run();
    }

}

// Start server
$server = new DemoSocketServer();
$server->run();