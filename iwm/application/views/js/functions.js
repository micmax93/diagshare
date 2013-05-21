/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */

function userAuthorized(v) {
    if (v["status"] == "ok")
        window.location = "authorized";
}

function authorizeUser() {
    var user = document.getElementById('userInput').value;
    var pass = document.getElementById('passwordInput').value;
    $.ajax({
        type: "POST",
        url: "authorize",
        data: {username: user, password: pass},
        success: userAuthorized
    });
}

function removePatient(id) {
    $.ajax({
        dataType: "json",
        url: "index.php/patient/delete/" + id,
        patientListItem: "patientListItem_" + id,
        windowName: name + "_window",
        success: function (v) {
            if (v["status"] == "ok") {
                var okna = $('#' + this.patientListItem).attr('listOfWindows');
                okna = okna.split(",");
                for (var i = 0; i < okna.length; i++) closeWindow(okna[i]);
                $('#' + this.patientListItem).remove();
            }
        }
    });
}

function popupWindow(title, url) {

    var newWindow = window.open(url, title, "'height=400,width=400,toolbar=no,scrollbars=yes,location=no,resizable=yes'");
    if (window.focus) {
        newWindow.focus()
    }
    return newWindow;
}

function popupWindowOpt(title, url, opt) {
    var newWindow = window.open(url, title, opt);
    if (window.focus) {
        newWindow.focus()
    }
    return newWindow;
}

function blockBoard() {
//    $('#main').block({ message: null, overlayCSS: { opacity: 0, position: 'absolute'}});
    $('#main').css('pointer-events', 'none');
    $('#roomList').css('background', 'black').css('opacity', 0.2).css('pointer-events', 'none');
    $('#messageBox').css('background', 'black').css('opacity', 0.2).css('pointer-events', 'none');
    $('#chatControl').css('background', 'black').css('opacity', 0.2).css('pointer-events', 'none');

}

function unlockBoard() {
    //   $('#main').unblock();
    $('#main').css('pointer-events', 'auto');
    $('#roomList').css('background', '#3C9DD0').css('opacity', 1).css('pointer-events', 'auto');
    $('#messageBox').css('background', '#3C9DD0').css('opacity', 1).css('pointer-events', 'auto');
    $('#chatControl').css('background', '#3C9DD0').css('opacity', 1).css('pointer-events', 'auto');
}

