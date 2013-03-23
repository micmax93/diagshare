/**
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:50
 */
var listaOkien = Array();

function createWindow(parentId, id, width, height, rows, rowSize, images) {

    // Oznacz wszystkie pozostałe okna jako nieaktywne
    var window;
    for (var i = 0; i < listaOkien.length; i++) {
        window = document.getElementById(listaOkien[i]);
        window.style.zIndex = 0;
        window.getElementsByTagName("div")[0].className = "titleBar";
    }

    // Dodaj diva ze strukturą okna
    $('#' + parentId).append('' +
        '<div class="imageWindow" id="' + id + '_window"  onmousedown="firstPlanWindow(\'' + id + '_window\');">' +
        '   <div class="titleBarActive" onmousedown="firstPlanWindow(\'' + id + '_window\');"><p>' + id + ' [' + width*rowSize + 'x' + height*rows + ']</p>' +
        'Zoom:' +
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

    // Dodaj okno do listy i umożliw jego przesuwanie a także zwiększ o wysokość paska tytułowego
    listaOkien.push(id + '_window');
    $('#' + id + '_window').draggable().css('top', (listaOkien.length * 20)).width(width*rowSize).height(height*rows + 20);

    // Dodaj kanwę

    if (!Array.isArray(images)) {
        tc = addCanvas(id + '_grid', id + '_img');
        // Rysuj zdjęcie
        drawOnCanvas(id + '_img', images, 1);


    }
    else
    {
        for(var i=0;i<images.length;i++)
        {

            tc = addCanvas(id + '_grid', id + '_img'+i);
            if(((i+1)%rowSize) == 0)
                addNewLine(id+'_grid');
            // Rysuj zdjęcie
            drawOnCanvas(id + '_img' +i, images[i], 1);
        }

    }
    tc.addEventListener('mousedown', function () {
        firstPlanWindow(id + '_window');
    }, false);


    // using the event helper
    $('#' + id + '_viewport').bind('mousewheel', function (event, delta, deltaX, deltaY) {
        zoom(id + '_grid', ((delta > 0) ? 1.1 : 0.9));
    });


    // Ustaw przesuwalność zdjęć wewnątrz viewportu i pierwszoplanowość okna
    $('#' + id + '_grid').draggable();
    $('#' + id + '_viewport').css('z-index', 0);
    $('#' + id).css('z-index', 0);
}

function closeWindow(id) {
    $('#' + id).css('display', 'none');
    for(var i=0;i<listaOkien.length; i++)
    {
        if(listaOkien[i] == id)
            listaOkien.splice(i,1);
    }
}

function firstPlanWindow(name) {
    var window;
    for (var i in listaOkien) {
        window = document.getElementById(listaOkien[i]);
        window.style.zIndex = 0;
        window.getElementsByTagName("div")[0].className = "titleBar";

    }
    window = document.getElementById(name);
    window.style.zIndex = 1;
    window.getElementsByTagName("div")[0].className = "titleBarActive";

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

