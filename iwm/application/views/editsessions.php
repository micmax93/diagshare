<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>Sessions...</title>
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
<h4>Saved sessions</h4>
<table class="viewList" id="vList" style="display: block;">
<script>

if(window.opener.liveListener != null) {
      document.getElementById(\'vList\').style.display = "none";
}
else
      document.getElementById(\'vList\').style.display = "block";
</script>

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
    echo '<tr onclick="window.opener.applyBoardState(' . $view->id . ');window.close();"><td>' . $users[$view->owner_id] . '</td><td> ' . $view->start . ' </td><td>' . $view->end . '</td> </tr>';
}

echo '
</tbody>
</table>

<script>
    window.opener.request("list",0);
    window.opener.requestSessionList();
</script>
<h4>Online sessions</h4>

<table class="viewList" id="sessionList">
<thead><tr><th>username</th></tr></thead>
<tbody>
</tbody>
</table>
<hr>
<script>
if(window.opener.liveListener != null) {
    document.write(\'<button onclick="window.opener.sendSessionIgnore();window.close();">Stop live sync</button>\');
} else
{
    if(window.opener.liveChanel != null)
        document.write(\'<button onclick="window.opener.stopLiveSession();window.close();">Stop live</button>\');
    else
        document.write(\'<button onclick="window.opener.startLiveSession();window.close();">Start live</button> \');

}
</script>


</body>
</html> ';

?>