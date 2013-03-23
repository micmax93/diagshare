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
        canvas.width = img.width * scale;
        canvas.height = img.height * scale;
        context.drawImage(img, 0, 0, img.width * scale, img.height * scale);
    };
    img.src = imageUrl;

}


function addNewLine(parentId) {

    $('#' + parentId).append("<br>");
}

function zoom(id, scale) {

    var grid = $('#' + id);
    var h;
    var w;

    h = grid.height();
    w = grid.width();

    grid.height(grid.height() * scale);
    grid.width(grid.width() * scale);

    h = h - grid.height();
    w = w - grid.width();
    grid.css('top', parseInt(grid.css('top')) + (h / 2));
    grid.css('left', parseInt(grid.css('left')) + (w / 2));

}


function contrastGrid(id, value) {
    var grid = document.getElementById(id);
    var canvases = grid.getElementsByTagName("canvas");
    for (var i = 0; i < canvases.length; i++) {
        Caman('#' + canvases[i].id, function () {
            this.contrast(value);
            this.render();
        });
    }
}

function brightnessGrid(id, value) {
    var grid = document.getElementById(id);
    var canvases = grid.getElementsByTagName("canvas");
    for (var i = 0; i < canvases.length; i++) {
        Caman('#' + canvases[i].id, function () {
            this.brightness(value);
            this.render();
        });
    }
}