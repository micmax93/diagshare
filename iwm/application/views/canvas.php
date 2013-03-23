<?php

echo '
<script type="text/javascript">
var graphic = new Array();
var map = new Array();
var zdjecia = new Array();
var tc;

';
$j = 0;
foreach ($images as $k => $v) {

    $size = getimagesize($v["images"][0]);
    $size[0] = round($size[0] * $imageSettings["scale"]);
    $size[1] = round($size[1] * $imageSettings["scale"]);

    echo 'var urlList'.$j.' = Array();
    ';
    $i = 0;
    foreach($v["images"] as $image)
    {

        echo 'urlList'.$j.'['.$i.'] = "'.$image.'";
        ';
        $i++;
    }
    echo '
        createWindow(\'main\',\'' . $k . '\',' . $size[0] . ',' . $size[1] . ','.$v["rowSize"].','.$v["numberOfRows"].', urlList'.$j.');
    ';

    $j++;
}

echo '
</script>

';