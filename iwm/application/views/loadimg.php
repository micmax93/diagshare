<?php

echo '
<!DOCTYPE html>
<html>
<head>
 <title>Image Upload</title>
 <link rel="stylesheet" type="text/css" href="' . URL::base() . 'application/views/css/loadimg.css">
</head>
<body>
<h1>Upload image</h1>
';
if (isset($message)) echo $message;
if (!isset($loading))
    echo '
<form enctype="multipart/form-data" method="post">
                <input type="text" size="20" name="img_title" placeholder="title"><br>
                <input type="file" size="20" name="img_upload" value=""><br>
                <input type="text" name="patient_id" value="' . $patientId . '" style="display:none;visibility:hidden;">
                <input type="submit" value="Upload">
</form>';
echo '
</body>
</html> ';

?>