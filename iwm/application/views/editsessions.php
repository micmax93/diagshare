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
</head>
<body>
<h1>Sessions</h1>';
if (isset($message)) echo $message;
else {
  echo 'ok';
}

echo '
</body>
</html> ';

?>