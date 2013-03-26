/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */

function roomsReceived(data) {

    var list = '';
    $.each(data, function (room, patients) {
        list += '<h3>' + room + '</h3>';
        $.each(patients, function (patient, photos) {

            list += '<div class="roomz">';
            list += '   <h3>' + patient + '</h3>';
            list += '   <div style="height: 100%;">';
            list += '       <ul>';

            $.each(photos, function (photo) {
                list += '       <li>';
                list += '           <a href="javascript:showHide(\'' + photo + '_window\');">' + photo + '</a>';
                list += '       </li>';
            });
            list += '       </ul>';
            list += '   </div>';
            list += '</div>';

        });


    });
    document.getElementById('rooms').innerHTML = list;

    $(function () {
        $("#rooms").accordion({
            collapsible:true
        });
    });


    $(function () {
        $(".roomz").accordion({
            collapsible:true
        });
    });


}