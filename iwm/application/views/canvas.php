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
    <div class="image" id="' . $k . '">
        <div class="titleBar"><p>'.$k.'</p><a href="javascript:showHideImage(\''.$k.'_img\');">S/H</a></div>
        <img src="' . $v . '" id="' . $k . '_img">
    </div>';
}
echo '
<script type="text/javascript">
';
foreach ($images as $k => $v) {
    echo '  $( "#' . $k . '" ).draggable();';
    //echo '  $( "#' . $k . '" ).draggable({ containment: "parent" });';
    printf("\n");
    echo "  document.getElementById('" . $k . "').style.width = parseInt(document.getElementById('" . $k . "_img').width)+'px';";
    printf("\n");
    echo "  document.getElementById('" . $k . "').style.height = (parseInt(document.getElementById('" . $k . "_img').height+20))+'px';";
    printf("\n");
}
echo '
</script>
';