/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:50
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

var listaOkien = Array();

function firstPlanByName(name) {
    for (var i in listaOkien) {
        document.getElementById(listaOkien[i]).style.zIndex = 0;
    }
    document.getElementById(name).style.zIndex = 1;

}
