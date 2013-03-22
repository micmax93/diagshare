/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */
function showHide(thing) {
    var el = document.getElementById(thing);
    if (el.style.display == "none") {
        el.style.display = "block";
        //el.parentNode.style.height = parseInt(el.height) + "px";
    }
    else {
        el.style.display = "none";
        //el.parentNode.style.height = (parseInt(el.parentNode.style.height) - parseInt(el.height)) + "px";

    }

}

function firstPlan(e) {
    for (var i in listaOkien) {
        document.getElementById(listaOkien[i]).style.zIndex = 0;
    }
    e.target.parentNode.style.zIndex = 1;
}


function changeContrast(cName, val) {
    if($('.' + cName).css('-webkit-filter') == "none")
    {
        $('.' + cName).css('-webkit-filter','brightness(0)');
    }

    var brightness = $('.' + cName).css('-webkit-filter').toString();
    brightness = brightness.replace("brightness(","","gi").replace(")","","gi");
    var value = Math.floor(parseFloat(brightness)*16)/16 + val/16;
    $('.' + cName).css('-webkit-filter','brightness('+value+')');


}