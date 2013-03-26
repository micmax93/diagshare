/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */

function menuRoll(thing) {
    var el = document.getElementById(thing);
    if (el.style.display == "none") {
     el.style.display = "block";
     }
     else {
     el.style.display = "none";
     //el.parentNode.style.height = (parseInt(el.parentNode.style.height) - parseInt(el.height)) + "px";

     }

}


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

            $.each(photos, function (photo) {
                list += '       <li>';
                list += '           <a href="javascript:showHide(\'' + photo + '_window\');">' + photo + '</a>';
                list += '       </li>';

            });
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