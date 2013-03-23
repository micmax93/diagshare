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
        Reset: <a href="javascript:resetFilter(\'' . $k . '_img\');" class="smallButton">R</a>
        <a href="javascript:showHide(\'' . $k . '_window\');" class="close">X</a></div>
        <div class="viewport" id="' . $k . '_viewport">
            <div class="imageGrid" id="' . $k . '_grid">
            </div>
        </div>
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
    $size[0] = $size[0] * $imageSettings["scale"];
    $size[1] = $size[1] * $imageSettings["scale"];

    echo "
        $('#" . $k . "_window').draggable();
        $('#" . $k . "_window').css('top'," . ($i * 20) . ");
        $('#" . $k . "_window').width(" . $size[0] . ");
        $('#" . $k . "_window').height(" . ($size[1] + 20) . " );
        $('#" . $k . "').width(" . $size[0] . ");
        $('#" . $k . "').height(" . $size[1] . ");

        addCanvas('" . $k . "_grid','" . $k . "_img');
        drawOnCanvas('" . $k . "_img','" . $v . "',1);
        $('#" . $k . "_grid').draggable();

        $('#" . $k . "').css('z-index',0);
        listaOkien.push('" . $k . "_window');

    ";
    $i++;

}
echo '
</script>

';