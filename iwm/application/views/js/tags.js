/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 06.04.13
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */

/**
 * addTag()
 * Dodaje tag i umożliwia jego przesuwanie.
 * @param parentId
 * @param id
 * @param top
 * @param left
 * @param content
 */
function addTag(parentId, id, top, left, content) {
    $('#' + parentId).append('<div class="imageTag" id="' + id + '">' + content + '</div>');
    $('#' + id).css('top', top).css('left', left).draggable({opacity:0.6}).click(function () {
        var pole = this.innerHTML;
        //this.innerHTML = "<input "
        //document.getElementById(id).contentEditable = 'true';
    });
}

/**
 * fixTagsPositions()
 * Naprawia pozycje tagów w trakcie zoomowania
 * @param gridId
 * @param scale
 */
function fixTagsPositions(gridId, scale) {
    var grid = $('#' + gridId);
    $('#' + gridId + ' > .imageTag').each(function () {
        this.style.top = parseFloat(this.style.top) * scale + "px";
        this.style.left = parseFloat(this.style.left) * scale + "px";
    });
}


//var h = parseFloat(this.style.top) / parseFloat(grid.height());
//var w = parseFloat(this.style.left) / parseFloat(grid.width());
