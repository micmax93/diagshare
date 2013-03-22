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


function changeFilter(cName, br, con, blur) {

    if ($('.' + cName).css('-webkit-filter') == "none") {
        $('.' + cName).css('-webkit-filter', 'brightness(0) contrast(1) blur(0px)');
    }

    var dane = $('.' + cName).css('-webkit-filter').toString();
    var oBr = dane.match(/[0-9\-]+.[0-9]+|[0-9]/);
    dane = dane.replace("brightness(" + oBr + ")", "");
    var oCo = dane.match(/[0-9\-]+.[0-9]+|[0-9]/);
    dane = dane.replace("contrast(" + oCo + ")", "");
    var oBl = dane.match(/[0-9\-]+.[0-9]+|[0-9]/);
    dane = dane.replace("blur(" + oCo + "px)", "");

    oBr = parseFloat(oBr) + parseFloat(br) / 16;
    oCo = parseFloat(oCo) + parseFloat(con) / 8;
    oBl = parseInt(oBl) + parseInt(blur);

    $('.' + cName).css('-webkit-filter', 'brightness(' + oBr + ') contrast(' + oCo + ') blur(' + oBl + 'px)');

}
