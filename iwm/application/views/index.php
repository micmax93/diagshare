<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>' . $title . '</title>
 <link href="http://fonts.googleapis.com/css?family=Share+Tech+Mono" rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/style.css">
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/jquery-ui.css">
 <script type="text/javascript">
  var base_url = "'.URL::base().'";
  var wsUri = "ws://echo.websocket.org/";
  var webSocket;
 </script>
 <script src="' . URL::base() . 'application/views/js/jquery-1.9.1.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery-ui.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery.mousewheel.js"></script>
 <script src="' . URL::base() . 'application/views/js/caman.full.min.js"></script>
 <script src="' . URL::base() . 'application/views/js/communication.js"></script>
 <script src="' . URL::base() . 'application/views/js/functions.js"></script>
 <script src="' . URL::base() . 'application/views/js/canvas.js"></script>
 <script src="' . URL::base() . 'application/views/js/windows.js"></script>
 <script src="' . URL::base() . 'application/views/js/setup.js"></script>
</head>
<body onload="setup()">
<div id="container">
    <div id="sideBar">
        <h1>diagShare </h1>
        <button onclick="alert(JSON.stringify(getBoardState()));">StanPlanszy</button>
        <div id="roomList">
        ' . $room . '
        </div>
        <div id="messageBox">
        ' . $chat . '
        </div>

    </div>
    <div id="main">' . $canvas . '
    </div>
</div>
</body>

</html> ';

?>