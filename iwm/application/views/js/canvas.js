/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */


function addCanvas(parentId, id) {
    var newCanvas = $('<canvas/>', {'id':id});
    newCanvas.className = "imageCanvas";
    $('#' + parentId).append(newCanvas);
    var retCanvas = document.getElementById(id);
    retCanvas.className = "imageCanvas";
    return retCanvas;
}


function drawOnCanvas(id, imageUrl, scale) {
    var canvas = document.getElementById(id);
    var context = canvas.getContext('2d');
    var img = new Image();

    img.onload = function () {

        canvas.width = img.width*scale;
        canvas.height = img.height*scale;
        context.drawImage(img, 0, 0, img.width*scale, img.height*scale);
    };
    img.src = imageUrl;

}

function addNewLine(parentId) {

    $('#' + parentId).append("<br>");
}

function zoomCanvas(x, scale) {

    var canvas = document.getElementById(x);
    var imageUrl = canvas.toDataURL("image/jpeg");

    var context = canvas.getContext('2d');
    var img = new Image();

    img.onload = function () {

        canvas.width = img.width*scale;
        canvas.height = img.height*scale;
        context.drawImage(img, 0, 0, img.width*scale, img.height*scale);
    };
    img.src = imageUrl;


}

function zoomGrid(parentId, level) {
    var kanwy = document.getElementById(parentId).getElementsByClassName("imageCanvas");
    for (var i = 0; i < kanwy.length; i++)
        zoomCanvas(kanwy[i].id, parseInt(level));

}

