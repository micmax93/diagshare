/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */

/**
 * addCanvas()
 * Do podanego elementu nadrzędnego dodaje nową kanwę
 *
 * @param parentId
 * @param id
 * @return {HTMLElement}
 */
function addCanvas(parentId, id) {
    var newCanvas = $('<canvas/>', {'id':id});
    newCanvas.className = "imageCanvas";
    $('#' + parentId).append(newCanvas);
    var retCanvas = document.getElementById(id);
    retCanvas.className = "imageCanvas";
    return retCanvas;
}


/**
 * drawOnCanvas()
 * Dla kanwy o podanym id rysuje obraz z podanego URL w przyjętej skali.
 * @param id
 * @param imageUrl
 * @param scale
 */
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

/**
 * addNewLine()
 * Robi <br> - sposób na nowy wiersz w gridzie
 *
 * @param parentId
 */
function addNewLine(parentId) {

    $('#' + parentId).append("<br>");
}

/**
 * zoom()
 * Powiększa i przesuwa grid w zależności od skali.
 * @param id
 * @param scale
 */
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


var contrastList = Array();
/**
 * contrastGrid()
 * Zwiększa kontrast.
 *
 * @param id
 * @param value
 */
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


var brightnessList = Array();

/**
 * brightnessGrid()
 * Zwiększa jasność
 *
 * @param id
 * @param value
 */
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

/**
 * canvasRevert()
 * Odwraca skutki działania filtrów i ustawia grid na pozycji (0,0)
 * @param id
 */
function canvasRevert(id) {
    var grid = document.getElementById(id);
    grid.style.top = 0;
    grid.style.left = 0;
    var canvases = grid.getElementsByTagName("canvas");
    for (var i = 0; i < canvases.length; i++) {
        Caman('#' + canvases[i].id, function () {
            this.revert();
        });
    }

}