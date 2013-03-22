<?php


foreach ($images as $k => $v) {
    $size = getimagesize($v);
    echo '
    <div class="imageWindow" id="' . $k . '_window"  onmousedown="firstPlan(event)">
        <div class="titleBar"><p>' . $k . ' [' . $size[0] . 'x' . $size[1] . ']</p>B:
        <a href="javascript:changeFilter(\'' . $k . '_img\',1,0,0);" class="smallButton">+</a>
        <a href="javascript:changeFilter(\'' . $k . '_img\',-1,0,0);" class="smallButton">-</a>
        C:
        <a href="javascript:changeFilter(\'' . $k . '_img\',0,1,0);" class="smallButton">+</a>
        <a href="javascript:changeFilter(\'' . $k . '_img\',0,-1,0);" class="smallButton">-</a>
        O:
        <a href="javascript:changeFilter(\'' . $k . '_img\',0,0,1);" class="smallButton">+</a>
        <a href="javascript:changeFilter(\'' . $k . '_img\',0,0,-1);" class="smallButton">-</a>


        <a href="javascript:showHide(\'' . $k . '_window\');" class="close">X</a></div>
        <div class="image" id="' . $k . '"></div>
    </div>';
}
echo '
<script type="text/javascript">
var graphic = new Array();
var map = new Array();
var zdjecia = new Array();

';
$i = 0;
foreach ($images as $k => $v) {
    $size = getimagesize($v);
    $size[0] = $size[0] * $imageSettings["ratio"];
    $size[1] = $size[1] * $imageSettings["ratio"];

    echo "
        $('#" . $k . "_window').draggable();
        $('#" . $k . "_window').css('top'," . ($i * 20) . ");
        $('#" . $k . "_window').width(" . $size[0] . ");
        $('#" . $k . "_window').height(" . ($size[1] + 20) . " );
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

        $('#" . $k . "').css('z-index',0);
        $('#" . $k . "').find('img').map(function(){
            this.className='" . $k . "_img';
            return this;
        }).get();


        listaOkien.push('" . $k . "_window');

    ";
    $i++;

}
echo '
</script>

';