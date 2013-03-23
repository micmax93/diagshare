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

function firstPlanByName(name) {
    for (var i in listaOkien) {
        document.getElementById(listaOkien[i]).style.zIndex = 0;
    }
    document.getElementById(name).style.zIndex = 1;

}


function changeFilter(cName, br, con, blur) {

    /* if ($('.' + cName).css('-webkit-filter') == "none") {
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

     $('.' + cName).css('-webkit-filter', 'brightness(' + oBr + ') contrast(' + oCo + ') blur(' + oBl + 'px)');          */

}


function resetFilter(cName) {
    // $('.' + cName).css('-webkit-filter', 'brightness(0) contrast(1) blur(0px)');
}


function addCanvas(parentId, id) {
    var newCanvas = $('<canvas/>', {'id':id});
    newCanvas.className = "imageCanvas";
    $('#' + parentId).append(newCanvas);
    var retCanvas = document.getElementById(id)
    retCanvas.className = "imageCanvas";
    return retCanvas;
}


function drawOnCanvas(id, imageUrl, scale) {

    var canvas = document.getElementById(id);
    var img = new Image();

    img.onload = function () {
        canvas.width = img.width * scale;
        canvas.height = img.height * scale;
        canvas.getContext('2d').drawImage(img, 0, 0, img.width * scale, img.height * scale);
    };
    img.src = imageUrl;

}

function addNewLine(parentId) {

    $('#' + parentId).append("<br>");
}


function zoomCanvas(x, level) {
    var canvas = document.getElementById(x);
    var image = new Image();
    drawOnCanvas(x, canvas.toDataURL("image/png"), level);

}

function zoomGrid(parentId, level) {
    var kanwy = document.getElementById(parentId).getElementsByClassName("imageCanvas");
    for (var i = 0; i < kanwy.length; i++)
        zoomCanvas(kanwy[i].id, level);

}