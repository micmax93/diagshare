<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>' . $title . '</title>
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/style.css">
 <link rel="stylesheet" href="' . URL::base() . 'application/views/css/jquery.window.css" type="text/css">
 <script src="' . URL::base() . 'application/views/js/jquery-1.9.1.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery-ui.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery.mousewheel.js"></script>
 <script src="' . URL::base() . 'application/views/js/caman.full.min.js"></script>
 <script src="' . URL::base() . 'application/views/js/functions.js"></script>
 <script src="' . URL::base() . 'application/views/js/windows.js"></script>
 <script src="' . URL::base() . 'application/views/js/canvas.js"></script>
 <script src="' . URL::base() . 'application/views/js/setup.js"></script>
</head>
<body onload="setup()">
<div id="container">
    <div id="sideBar">
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