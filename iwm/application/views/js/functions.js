/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */

function roomsReceived(data) {
    var list = "";
    $.each(data, function (room, patients) {
        list += '<li>' + room;
        list += '<ul>';
        $.each(patients, function (patient, photos) {
            list += '<li>' + patient;
            list += '<ul>';
            $.each(photos, function (photo) {
                list += '<li>';
                list += '<a href="javascript:showHide(\''+photo+'_window\');">'+photo+'</a>';
                list += '</li>';
            });
            list += '</ul>';
            list += '</li>';
        });
        list += '</ul>';
        list += '</li>';
        document.getElementById('rooms').innerHTML = list;
        //items.push('<li id="' + key + '">' + val + '</li>');
    });
}