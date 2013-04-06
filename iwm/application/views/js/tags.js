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
    $('#' + parentId).append('<div class="imageTag" id="' + id + '"><p>' + content + '</p></div>');
    $('#' + id).css('top', top).css('left', left).draggable({opacity:0.6}).dblclick(function () {
        if ($(this).hasClass("in-edit")) {
            this.innerHTML = "<p>" + this.childNodes[0].value + "</p>";
            $(this).removeClass("in-edit");
            updateTag(id, this.childNodes[0].innerHTML);
        }
        else {
            $(this).addClass("in-edit");
            this.innerHTML = '<input value="' + this.childNodes[0].innerHTML + '">';

        }
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


function updateTag(id, value) {
    alert(id + ' :' + value);
}

//var h = parseFloat(this.style.top) / parseFloat(grid.height());
//var w = parseFloat(this.style.left) / parseFloat(grid.width());
