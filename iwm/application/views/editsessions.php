<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>Manage Rooms...</title>
 <link href="http://fonts.googleapis.com/css?family=Share+Tech+Mono" rel="stylesheet" type="text/css">
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/editsessions.css">
 <script src="' . URL::base() . 'application/views/js/jquery-1.9.1.js"></script>
 <script src="' . URL::base() . 'application/views/js/jquery-ui.js"></script>
 <script>
    var baseUrl = "' . URL::base() . '";
    var sessionWindow = window.opener.sessionWindow;
    var userList = Array();
    ';
foreach ($userData as $user) {
    echo "userList[" . $user->id . "] = '" . $user->username . "';
    ";
}
echo '
 </script>
</head>
<body>
<h1>Sessions</h1>';
if (isset($message)) echo $message;
else {
    echo '';
}
echo '
<button onclick="window.opener.saveView();window.close();">Save board state</button><br>
<br>
<table class="viewList">
<thead>
<tr>
<th>
username
</th>
<th>
start time
</th>
<th>
end time
</th>
</tr>
</thead>
<tbody>
';

foreach ($views as $view) {
    echo '<tr onclick="window.opener.applyBoardState(' . $view->id . ');"><td>' . $users[$view->owner_id] . '</td><td> ' . $view->start . ' </td><td>' . $view->end . '</td> </tr>';
}

echo '
</tbody>
</table>

<hr>
<button onclick="window.opener.startLiveSession();">Start live</button>
<button onclick="window.opener.sendSessionUpdate();">Update state</button>
<button onclick="window.opener.stopLiveSession();">Stop live</button>
<script>
    window.opener.request("list",0);
    window.opener.requestSessionList();
</script>
<h4>Sesje live</h4>
<table class="viewList" id="sessionList">
<thead><tr><th>username</th></tr></thead>
<tbody>
</tbody>
</table>
</body>
</html> ';

?>