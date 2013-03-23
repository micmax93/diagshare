/**
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:50
 */
var listaOkien = Array();

function createWindow(parentId, id, width, height, imgUrl) {

    $('#' + parentId).append('' +
        '<div class="imageWindow" id="' + id + '_window"  onmousedown="firstPlanWindow(\'' + id + '_window\');">' +
        '   <div class="titleBar" onmousedown="firstPlanWindow(\'' + id + '_window\');"><p>' + id + ' [' + width + 'x' + height + ']</p>' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',1.1);" class="smallButton">+</a>' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',0.9);" class="smallButton">-</a>' +
        '       <a href="javascript:closeWindow(\'' + id + '_window\');" class="close">X</a>' +
        '   </div>' +
        '   <div class="viewport" id="' + id + '_viewport">' +
        '       <div class="imageGrid" id="' + id + '_grid">' +
        '       </div>' +
        '   </div>' +
        '</div>' +
        '');
    listaOkien.push(id + '_window');
    $('#' + id + '_window').draggable().css('top', (listaOkien.length * 20)).width(width).height(height + 20);
    $('#' + id).width(width).height(height);


    tc = addCanvas(id + '_grid', id + '_img');
    tc.addEventListener('mousedown', function () {
        firstPlanWindow(id + '_window');
    }, false);
    drawOnCanvas(id + '_img', imgUrl, 1);
    $('#' + id + '_grid').draggable();
    $('#' + id + '_viewport').css('z-index', 0);
    $('#' + id).css('z-index', 0);
    listaOkien.push(id + '_window');
}

function closeWindow(id) {
    $('#' + id).css('display', 'none');
}

function firstPlanWindow(name) {
    for (var i in listaOkien) {
        document.getElementById(listaOkien[i]).style.zIndex = 0;
    }
    document.getElementById(name).style.zIndex = 1;

}

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

