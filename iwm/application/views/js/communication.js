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

var chatType='tag';
var chatId=3;
var chatLast=0;

function sendChatMessage() {
    var msg = document.getElementById('chatInput').value;
    //webSocket.send(msg);
    var data={};
    data["type"]="tag";
    data["id"]=3;
    data["content"]=msg;
    //jQuery.post( url [, data ] [, success(data, textStatus, jqXHR) ] [, dataType ] )
    jQuery.post("index.php/chat/newpost",data);
}

function sendMsg(cmd,type,id)
{
    if(webSocket.isOpen())
    {
        var str='{"cmd":"'+cmd+'","type":"'+type+'","id":'+id+'}';
        webSocket.send(str);
    }

}

function register()
{sendMsg('register','user','0');}
function request(type,id)
{sendMsg('request',type,id);}
function ignore(type,id)
{sendMsg('ignore',type,id);}

function downloadPosts()
{
    var args={};
    args['id']=chatId;
    args['last']=chatLast;
    jQuery.post("index.php/chat/"+chatType,args,function(data){

        for(i=0;i<data.length;i++)
        {
            $('#chatList').append("<tr><td>" + data[i]['owner'] + ": " + data[i]['content'] + "</td></tr>");
            chatLast=data[i]['id'];
        }
    });

}

function setChat(type,id)
{
    ignore(chatType,chatId);
    chatType=type;
    chatId=id;
    chatLast=0;
    request(chatType,chatId);
    downloadPosts();
}


function setupWebSocket() {

    webSocket = new WebSocket("ws://" + window.location.host + ":12345/echo");
    webSocket.onopen = function (evt) {
        register();
    };
    webSocket.onclose = function (evt) {
        onClose(evt)
    };
    webSocket.onmessage = function (evt) {
        onMessage(evt);
    };
    webSocket.onerror = function (evt) {
        onError(evt);

        //debug!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        downloadPosts();
    };

    //debug!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    setChat('tag',3);
}



function onClose(evt) {
    alert('Rozłączono!');
}
function onMessage(evt) {
    //$('#chatList').append("<tr><td>" + evt.data + "</td></tr>");
    data = jQuery.parseJSON(evt.data);
    if((data['type']==chatType)&&(data['id']==chatId))
    {
        downloadPosts();
    }
    //TODO odczytanie rodzaju zasobu
}
function onError(evt) {
    alert('Błąd czatu: ' + evt.data);
}
