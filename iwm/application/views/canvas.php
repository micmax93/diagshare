<?php

echo '
<script type="text/javascript">
var graphic = new Array();
var map = new Array();
var zdjecia = new Array();
var tc;

';
foreach ($images as $k => $v) {
    $size = getimagesize($v);
    $size[0] = $size[0] * $imageSettings["scale"];
    $size[1] = $size[1] * $imageSettings["scale"];

    echo '
        createWindow(\'main\',\'' . $k . '\',' . $size[0] . ',' . $size[1] . ',\'' . $v . '\');
    ';
}

echo '
</script>

';