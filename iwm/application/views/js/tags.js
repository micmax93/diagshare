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
    $('#' + id).css('top', top).css('left', left).draggable({opacity: 0.6, stop: function () {
        updateTagPosition(id);
    }}).dblclick(function () {
            if ($(this).hasClass("in-edit")) {
                this.innerHTML = "<p>" + this.childNodes[0].value + "</p>";
                $(this).removeClass("in-edit");
                updateTagText(id, this.childNodes[0].innerHTML);
            }
            else {
                $(this).addClass("in-edit");
                this.innerHTML = '<input value="' + this.childNodes[0].innerHTML + '" id="' + id + '_text"><button onclick="updateTagTextHideEdit(\'' + id + '\');"><img src="application/views/img/tick.png"></button>' +
                    '<button onclick="deleteTag(\'' + id + '\');"><img src="application/views/img/remove.png"></button>';

            }
        }).attr('basicTop', top).attr('basicLeft', left);
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

/**
 * updateTagText()
 * Aktualizuje tytuł tagu
 * @param id
 * @param value
 */
function updateTagText(id, value) {
    alert(id + ' :' + value);
}

/**
 * updateTagPosition()
 * @param id
 * @param top
 * @param left
 */
function updateTagPosition(id) {
    var el = document.getElementById(id);

}

/**
 * deleteTag()
 * @param id
 */
function deleteTag(id) {
    var tag = document.getElementById(id);
    $.ajax({
        dataType: "json",
        url: "index.php/tag/delete/" + tag.id.substr(4),
        tag: tag,
        success: function (v) {
            if (v["status"] == "ok") {
                var tag = document.getElementById("tag_" + v["id"]);
                tag.parentNode.removeChild(tag);
            }

        }
    });

}

/**
 * updateTagTextHideEdit()
 * Aktualizuje tytuł tagu i zamyka pole edycji.
 * @param id
 */
function updateTagTextHideEdit(id) {
    var input = document.getElementById(id + '_text');
    input.parentNode.innerHTML = "<p>" + input.value + "</p>";
    $('#' + id).removeClass("in-edit");
    updateTagText(id, input.value);
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

//    addTag(e.target.parentNode.id, e.target.parentNode.id + '_tag' + Math.floor(Math.random() * 1000), y, x, "Tag nr. "+);

}

//var h = parseFloat(this.style.top) / parseFloat(grid.height());
//var w = parseFloat(this.style.left) / parseFloat(grid.width());
