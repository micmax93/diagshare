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
function createWindow(parentId, id, width, height, rowSize, rows, images) {

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
        '   <div class="titleBarActive" onmousedown="firstPlanWindow(\'' + id + '_window\');" id="' + id + '_title"><p>' + id + ' [' + width * rowSize + 'x' + height * rows + ']</p>' +
        'Zoom:' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',1.2);" class="smallButton">+</a>' +
        '       <a href="javascript:zoom(\'' + id + '_grid\',0.8);" class="smallButton">-</a>' +
        ' Contrast:' +
        '       <a href="javascript:contrastCanvas(\'' + id + '_img\',-20);" class="smallButton">+</a>' +
        '       <a href="javascript:contrastCanvas(\'' + id + '_img\',20);" class="smallButton">-</a>' +
        ' Brightness:' +
        '       <a href="javascript:brightnessCanvas(\'' + id + '_img\',20);" class="smallButton">+</a>' +
        '       <a href="javascript:brightnessCanvas(\'' + id + '_img\',-20);" class="smallButton">-</a>' +
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

    $('#' + id + '_window').draggable({opacity: 0.8, containment: "parent", handle: '#' + id + '_title' }).css('top', (listaOkien.length * 20)).width(width * rowSize).height(height * rows + 20);
    $('#' + id + '_grid').width(width * rowSize).height(height * rows).attr('basicHeight', height * rows).attr('basicWidth', width * rowSize);


    tc = addCanvas(id + '_grid', id + '_img', width * rowSize, height * rows);
    // Dodaj kanwę
    if (!Array.isArray(images)) {
        // Rysuj zdjęcie
        drawImage(id + '_img', images, 0, 0, 1);
    }
    else {
        var x = -1;
        var y = 0;
        for (var i = 0; i < images.length; i++) {
            x++;
            // Rysuj zdjęcie
            if ((i + 1) == images.length)
                drawImage(id + '_img', images[i], x * width, y * height, 1, 1);
            else
                drawImage(id + '_img', images[i], x * width, y * height, 1);
            if (((x + 1) % rowSize) == 0) {
                x = -1;
                y++;
            }

        }

    }

    // using the event helper
    $('#' + id + '_viewport').bind('mousewheel', function (event, delta, deltaX, deltaY) {
        zoom(id + '_grid', ((delta > 0) ? 1.2 : 0.8));
    });


    // Ustaw przesuwalność zdjęć wewnątrz viewportu i pierwszoplanowość okna
    $('#' + id + '_grid').draggable({cursor: "move"});
    $('#' + id + '_viewport').css('z-index', 0);
    $('#' + id + '_window').css('z-index', 1);

    //addTag(id + '_grid',id+'_tag',100,100,id+'_tag');
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
    if (window) {
        window.style.zIndex = 1;
        window.getElementsByTagName("div")[0].className = "titleBarActive";
    }
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
function showHideOrLoad(id, name) {
    var el = document.getElementById(name + '_window');

    if (!el) {
        var data;
        $.ajax({
            dataType: "json",
            url: base_url + "index.php/image/get/" + id,
            data: data,
            success: imageReceived
        });
    }
    else {
        if (el.style.display == "none") {
            el.style.display = "block";
            firstPlanWindow(name + '_window');
        }
        else {
            el.style.display = "none";

        }

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
        height: 'toggle'
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


/**
 * getBoardState()
 *
 * Pobiera w postaci JSON stan okien otwartych na planszy oraz przekształcenia wewnątrz
 */
function getBoardState() {

    var windows = Array();
    var el;
    var grid;
    var win = {};

    for (var i = 0; i < listaOkien.length; i++) {
        el = document.getElementById(listaOkien[i]);
        grid = document.getElementById(el.id.substr(0, el.id.length - 7) + "_grid");
        win = {};
        win.title = el.id.substr(0, el.id.length - 7);
        win.photoId = el.id.substr(0, el.id.length - 7);
        win.top = el.style.top;
        win.left = el.style.left;
        win.zoom = el.style.left;
        win.brightness = brightness[win.photoId + "_img"];
        win.contrast = contrast[win.photoId + "_img"];
        win.gridTop = grid.style.top;
        win.gridLeft = grid.style.left;
        win.gridHeight = grid.style.height;
        win.gridWidth = grid.style.width;
        win.display = el.style.display;
        win.firstPlan = el.style.zIndex;
        windows.push(win);
    }
    windows.sort(function (a, b) {
        return (a.firstPlan - b.firstPlan);
    });
    return windows;
}


/**
 * setBoardState()
 *
 * Odtwarza zwrócony przez getBoardState stan.
 *
 */
var currentView = Array();
function setBoardState(state) {
    // nadpisanie predefiniowanym stanem
    state = '[{"title":"Obraz1","photoId":"Obraz1","top":"40px","left":"","zoom":"","brightness":60,"gridTop":"107.667px","gridLeft":"55.6667px","gridHeight":"144.8px","gridWidth":"203.2px","display":"","firstPlan":"0"},{"title":"Zestaw1","photoId":"Zestaw1","top":"199px","left":"1136.83px","zoom":"1136.83px","brightness":-40,"contrast":60,"gridTop":"-1442.33px","gridLeft":"-1507.33px","gridHeight":"3715.2px","gridWidth":"3715.2px","display":"","firstPlan":"1"}]';


    // zamknij okna i usuń
    for (var i = 0; i < listaOkien.length; i++) {
        $('#' + listaOkien[i]).css('display', 'none').remove();
    }
    listaOkien.length = 0;

    var windows = JSON.parse(state);
    currentView = Array();
    for (var i = 0; i < windows.length; i++) {
        currentView[windows[i].title] = windows[i];
        showHideOrLoad(windows[i].title);

    }
}

function isNumber(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}
/**
 * applyFilter()
 * Aplikuje na istniejących oknach parametry dla aktywnego widoku (nie dotyczy zawartości)
 *
 * @param x
 */
function applyView(x) {
    var el = document.getElementById(x + '_window');
    var grid = document.getElementById(x + '_grid');
    if (el && currentView[x]) {
        el.style.top = currentView[x].top;
        el.style.left = currentView[x].left;
        el.style.zIndex = currentView[x].firstPlan;
        el.display = currentView[x].display;
        grid.style.top = currentView[x].gridTop;
        grid.style.left = currentView[x].gridLeft;
        grid.style.height = currentView[x].gridHeight;
        grid.style.width = currentView[x].gridWidth;

        if (isNumber(currentView[x].contrast))
            contrast[grid.id] = currentView[x].contrast;
        if (isNumber(currentView[x].brightness))
            brightness[grid.id] = currentView[x].brightness;


        //alert('w');

    }
}

/**
 * applyViewFilters()
 * Po załadowaniu treści okien aplikowane są filtry za pomocą tej funkcji
 * @param canvas
 */
function applyViewFilers(canvas) {
    var grid = canvas.parentNode;
    Caman('#' + canvas.id, function () {
        this.revert();
        if (isNumber(contrast[grid.id]))
            this.contrast(contrast[grid.id]);
        if (isNumber(brightness[grid.id]))
            this.brightness(brightness[grid.id]);
        this.render();

    });
}

