<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>Manage Rooms...</title>
 <link href="http://fonts.googleapis.com/css?family=Share+Tech+Mono" rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/editrooms.css">
 <script src="' . URL::base() . 'application/views/js/jquery-1.9.1.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery-ui.js"></script>
 <script>
 var baseUrl = "' . URL::base() . '";
 </script>
 <script src="' . URL::base() . 'application/views/js/rooms.js"></script>
</head>
<body>
<h1>Manage Rooms</h1>';
if (isset($message)) echo $message;
else {
    echo '<ul class="roomManageList">';
    foreach ($rooms as $room) {
        echo '<li>' . $room->id . '<input value="' . stripcslashes($room->name) . '" id="roomEdit_' . $room->id . '">
        <button onclick="saveRoom(' . $room->id . ');"><img src="' . URL::base() . 'application/views/img/tick.png" /></button>
        <button onclick="deleteRoom(' . $room->id . ');"><img src="' . URL::base() . 'application/views/img/remove-small.png" /></button>
        </li>';
    }
    echo '</ul>';

}

echo '
</body>
</html> ';

?>