/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 26.03.13
 * Time: 13:52
 * To change this template use File | Settings | File Templates.
 */

/**
 * roomsReceived
 * Funkcja ta tworzy strukturę html i umieszcza ją w panelu bocznym
 * po odebraniu struktury danych pokojów i pacjentów.
 *
 * @param data
 */
function roomsReceived(data) {

    var list = '';
    var lid = 0;
    $.each(data, function (room, patients) {
        list += '<h3>' + room + '</h3>';
        list += '<div class="rooms"  style="height:100%;">';
        $.each(patients, function (patient, photos) {

            list += '<div class="patient">';
            list += '   <h3><img src="application/views/img/folder-horizontal.png"><a href="javascript:menuRoll(\'patientLink' + lid + '\');">' + patient + '</a></h3>';
            list += '   <div id="patientLink' + lid + '" style="display:none;">';
            list += '       <ul>';

            for (var key in photos) {
                list += '       <li>';
                list += '           <a href="javascript:showHideOrLoad(\'' + photos[key] + '\',\'' + key + '\');">' + key + '</a>';
                list += '       </li>';

            }


            list += '       </ul>';
            list += '   </div>';
            list += '</div>';
            lid++;

        });
        list += '</div>';


    });
    document.getElementById('rooms').innerHTML = list;

    $(function () {
        $("#rooms").accordion({
            collapsible:true,
            autoHeight:true
        });
    });


}

/**
 * imageReceived()
 * Poniższa funkcja dla otrzymanych danych powoduje utworzenie okna.
 * @param v
 */
function imageReceived(v) {
    createWindow('main', v["title"], v["width"], v["height"], v["rowSize"], v["numberOfRows"], v["id"], v["images"]);
    applyView(v["title"]);
}


/**
 * addTags()
 * Zleca pobranie tagów dla zdjęcia.
 * @param photoId
 * @param canvasId
 */
function addTags(photoId, canvasId) {
    var data;
    $.ajax({
        dataType:"json",
        url:"index.php/tag/getAll/" + photoId,
        data:data,
        success:function (v) {
            tagsReceived(v, canvasId);
        }
    });

}

/**
 * tagsReceived()
 * Funkcja po otrzymaniu danych o tagach zaaplikuje je do zdjęcia
 *
 * @param v
 * @param gridId
 */
function tagsReceived(v, gridId) {
    for (var i = 0; i < v.length; i++) {
        addTag(gridId, "tag_" + v[i]["id"], v[i]["y"] + "px", v[i]["x"] + "px", v[i]["title"]);
    }


}


/**
 * sendChatMessage()
 * Wysyła dane z czatu
 * @param data
 */
function sendChatMessage() {
    var mesg = document.getElementById('chatInput');
    webSocket.send(mesg.value);
    mesg.value = "";
}


function setupWebSocket() {

    webSocket = new WebSocket(wsUri);
    webSocket.onopen = function (evt) {

    };
    webSocket.onclose = function (evt) {
        onClose(evt)
    };
    webSocket.onmessage = function (evt) {
        onMessage(evt);
    };
    webSocket.onerror = function (evt) {
        onError(evt);
    };
}

function onClose(evt) {
    alert('Rozłączono!');
}
function onMessage(evt) {
    //alert(evt.data);
    $('#chatList').append("<tr><td>" + evt.data + "</td></tr>");
    //webSocket.close();
}
function onError(evt) {
    alert('Błąd czatu: ' + evt.data);
}
