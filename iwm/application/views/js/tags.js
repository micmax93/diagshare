/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 06.04.13
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */

function tag(tagId, Tagtop, Tagleft, Tagcontent) {
    var id = id;
    var top = Tagtop;
    var left = Tagleft;
    var content = Tagcontent;

}


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
    $('#' + id).css('top', top).css('left', left).draggable({opacity: 0.6}).dblclick(function () {
        if ($(this).hasClass("in-edit")) {
            this.innerHTML = "<p>" + this.childNodes[0].value + "</p>";
            $(this).removeClass("in-edit");
            updateTag(id, this.childNodes[0].innerHTML);
        }
        else {
            $(this).addClass("in-edit");
            this.innerHTML = '<input value="' + this.childNodes[0].innerHTML + '">';
        }
    }).attr('basicTop', top).attr('basicLeft', left);
}

/**
 * addTags()
 * Zleca pobranie informacji o tagach przynależnych do danego zdjęcia i naniesienie ich na kanwę.
 * @param photoId
 * @param canvas
 */
function addTags(photoId,canvas)
{

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


/**
 * gridClicked()
 * Ustawia tag w miejscu kliknięcia na grid
 * @param e
 * @param id
 */
function gridClicked(e, id) {
    var x = e.pageX - $(e.target).offset().left;
    var y = e.pageY - $(e.target).offset().top;

    var ratioX = $(e.target.parentNode).attr('basicHeight') / parseFloat($(e.target.parentNode).height());
    var ratioY = $(e.target.parentNode).attr('basicWidth') / parseFloat($(e.target.parentNode).width());

    addTag(e.target.parentNode.id, e.target.parentNode.id + '_tag' + Math.floor(Math.random() * 1000), y, x, "Elo");
//    alert(x * ratioX + " " + y * ratioY);
}

//var h = parseFloat(this.style.top) / parseFloat(grid.height());
//var w = parseFloat(this.style.left) / parseFloat(grid.width());
