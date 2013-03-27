/**
 * User: phisikus
 * Date: 23.03.13
 * Time: 14:50
 */
var listaOkien = Array();

/**
 * createWindow()
 * Tworzy okno, jego elementy sterujące oraz grid i wywołuje addCanvas i drawOnCanvas
 * w celu wyrysowania wszystkich zdjęć na canvasach.
 * W miedzyczasie ustawia wszystkie parametry pozwalające na przesuwanie elementów.
 * @param parentId
 * @param id
 * @param width
 * @param height
 * @param rows
 * @param rowSize
 * @param images
 */
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
        '   <div class="titleBarActive" onmousedown="firstPlanWindow(\'' + id + '_window\');"><p>' + id + ' [' + width * rowSize + 'x' + height * rows + ']</p>' +
        'Zoom:' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',1.1);" class="smallButton">+</a>' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',0.9);" class="smallButton">-</a>' +
        ' Contrast:' +
        '       <a href="javascript:contrastGrid(\'' + id + '_grid\',-20);" class="smallButton">+</a>' +
        '       <a href="javascript:contrastGrid(\'' + id + '_grid\',20);" class="smallButton">-</a>' +
        ' Brightness:' +
        '       <a href="javascript:brightnessGrid(\'' + id + '_grid\',20);" class="smallButton">+</a>' +
        '       <a href="javascript:brightnessGrid(\'' + id + '_grid\',-20);" class="smallButton">-</a>' +
        ' Revert:' +
        '       <a href="javascript:canvasRevert(\'' + id + '_grid\',-20);" class="smallButton">O</a>' +
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

    $('#' + id + '_window').draggable({opacity:0.8, containment:"parent" }).css('top', (listaOkien.length * 20)).width(width * rowSize).height(height * rows + 20);
    $('#' + id + '_grid').width(width * rowSize).height(height * rowSize);

    // Dodaj kanwę
    if (!Array.isArray(images)) {
        tc = addCanvas(id + '_grid', id + '_img');
        // Rysuj zdjęcie
        drawOnCanvas(id + '_img', images, 1);

    }
    else {
        for (var i = 0; i < images.length; i++) {

            tc = addCanvas(id + '_grid', id + '_img' + i);
            if (((i + 1) % rowSize) == 0)
                addNewLine(id + '_grid');
            // Rysuj zdjęcie
            drawOnCanvas(id + '_img' + i, images[i], 1);
        }

    }

    // Początkowe wycofanie - żeby było widać wszystkie elementy
    zoom(id + '_grid', 1 / (Math.max(rows, rowSize)));


    // using the event helper
    $('#' + id + '_viewport').bind('mousewheel', function (event, delta, deltaX, deltaY) {
        zoom(id + '_grid', ((delta > 0) ? 1.1 : 0.9));
    });


    // Ustaw przesuwalność zdjęć wewnątrz viewportu i pierwszoplanowość okna
    $('#' + id + '_grid').draggable({cursor:"move"});
    $('#' + id + '_viewport').css('z-index', 0);
    $('#' + id).css('z-index', 0);
}

/**
 * closeWindow()
 * Zamyka okno - ukrywa, a potem usuwa z dokumentu i listy okien
 *
 * @param id
 */
function closeWindow(id) {
    $('#' + id).css('display', 'none').remove();
    for (var i = 0; i < listaOkien.length; i++) {
        if (listaOkien[i] == id)
            listaOkien.splice(i, 1);


    }
}

/**
 * firstPlanWindow()
 * Wyciąga okno na pierwszy plan i zmienia klasę paska tytułu
 * @param name
 */
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

/**
 * showHide()
 * Dla obiektu o podanym id ukrywa go bądź pokazuje (parametr display)
 * @param thing
 */
function showHide(thing) {
    var el = document.getElementById(thing);
    if (el.style.display == "none") {
        el.style.display = "block";
        firstPlanWindow(thing);
        //el.parentNode.style.height = parseInt(el.height) + "px";
    }
    else {
        el.style.display = "none";
        //el.parentNode.style.height = (parseInt(el.parentNode.style.height) - parseInt(el.height)) + "px";

    }

}

/**
 * showHideOrLoad()
 * Ukrywa bądź pokazuje okno.
 * Jeżeli nie istnieje - zostanie zainicjalizowane pobranie metadanych.
 * Funkcja imageReceived dokona dalszego wywołania createWindow dla odebranych danych.
 *
 * @param thing
 */
function showHideOrLoad(thing) {
    var el = document.getElementById(thing + '_window');

    if (!el) {
        var data;
        $.ajax({
            dataType:"json",
            url:base_url + "index.php/image/get/" + thing,
            data:data,
            success:imageReceived
        });
    }

    if (el.style.display == "none") {
        el.style.display = "block";
        firstPlanWindow(thing + '_window');
        //el.parentNode.style.height = parseInt(el.height) + "px";
    }
    else {
        el.style.display = "none";
        //el.parentNode.style.height = (parseInt(el.parentNode.style.height) - parseInt(el.height)) + "px";

    }

}

/**
 * menuRoll()
 *
 * Animowana funkcja ukrywania i rozwijania dla menu
 *
 * @param thing
 */
function menuRoll(thing) {
    $('#' + thing).animate({
        height:'toggle'
    }, 250, function () {

    });

    // Wariant statyczny
    /* var el = document.getElementById(thing);
     if (el.style.display == "none") {
     el.style.display = "block";
     }
     else {
     el.style.display = "none";
     }*/


}


