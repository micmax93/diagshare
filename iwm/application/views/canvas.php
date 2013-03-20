<?php

/*echo '

<canvas id="mainCanvas">
</canvas>
<script type="text/javascript">
 loadImage(\''.$image.'\');
</script>
';*/

foreach ($images as $k => $v) {
    echo '
    <div class="imageWindow" id="' . $k . '_window">
        <div class="titleBar"><p>'.$k.'</p><a href="javascript:showHideImage(\''.$k.'\');">S/H</a></div>
        <div class="image" id="'.$k.'"></div>
    </div>';
}
echo '
<script type="text/javascript">
var graphic = new Array();
var map = new Array();
';
$i = 0;
foreach ($images as $k => $v) {

    echo "
        map[".$i."] = new OpenLayers.Map('".$k."');
            graphic[".$i."] = new OpenLayers.Layer.Image(
                '".$k."',
                '".$v."',
                new OpenLayers.Bounds(-180, -88.759, 180, 88.759),
                new OpenLayers.Size(1024, 768),
                {numZoomLevels: 10}
            );
            map[".$i."].addLayers([graphic[".$i."]]);
            map[".$i."].addControl(new OpenLayers.Control.LayerSwitcher());
            map[".$i."].zoomToMaxExtent();
            document.getElementById('".$k."').style.width = 1024;
            document.getElementById('".$k."').style.height = 768;
    ";
    echo '$( "#' . $k . '_window" ).draggable();';
    $i++;

}
echo '
</script>
';