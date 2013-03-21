<?php


foreach ($images as $k => $v) {
  echo '
    <div class="imageWindow" id="' . $k . '_window">
        <div class="titleBar"><p>' . $k . '</p><!--<a href="javascript:showHideImage(\'' . $k . '\');">S/H</a>--></div>
        <div class="image" id="' . $k . '"></div>
    </div>';
}
echo '
<script type="text/javascript">
var graphic = new Array();
var map = new Array();
';
$i = 0;
foreach ($images as $k => $v) {
  $size = getimagesize($v);
  echo "
        $('#" . $k . "_window').draggable();
        $('#" . $k . "_window').width(" . $size[0] . ");
        $('#" . $k . "_window').height(" . $size[1] . "+22);
        $('#" . $k . "').width(" . $size[0] . ");
        $('#" . $k . "').height(" . $size[1] . ");
        map[" . $i . "] = new OpenLayers.Map('" . $k . "');
            graphic[" . $i . "] = new OpenLayers.Layer.Image(
                '" . $k . "',
                '" . $v . "',
                new OpenLayers.Bounds(-180, -88.759, 180, 88.759),
                new OpenLayers.Size(" . $size[0] . ", " . $size[1] . "),
                {numZoomLevels: 10}
            );
            map[" . $i . "].addLayers([graphic[" . $i . "]]);
            map[" . $i . "].zoomToMaxExtent();

    ";
  echo '$( "#' . $k . '_window" ).draggable();';
  $i++;

}
echo '
</script>
';