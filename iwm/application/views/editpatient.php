<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>Edit patient...</title>
 <link href="http://fonts.googleapis.com/css?family=Share+Tech+Mono" rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/editpatient.css">
</head>
<body>
<h1>';
if (isset($name))
    echo "Edit patient";
else
    echo "Add patient";

echo '</h1>
';
if (isset($message)) echo $message;
if (!isset($saved))
    echo '
<form enctype="multipart/form-data" method="post">
                <input type="text" size="32" name="name" placeholder="Name"'.(isset($name) ? 'value="'.$name.'"' : "").'><br>
                <input type="text" name="room_id" value="' . $room_id . '" style="display:none;visibility:hidden;">
                <input type="text" name="patient_id" value="' . (isset($patient_id) ? $patient_id : 0) . '" style="display:none;visibility:hidden;">
                <input type="submit" value="Save">
</form>';
echo '
</body>
</html> ';

?>