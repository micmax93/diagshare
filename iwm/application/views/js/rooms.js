/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 27.04.13
 * Time: 09:44
 * To change this template use File | Settings | File Templates.
 */

function deleteRoom(id) {

    $.ajax({
        dataType: "json",
        url: baseUrl + "index.php/room/delete/" + id,
        success: function (v) {
            window.close();
        }
    });

}