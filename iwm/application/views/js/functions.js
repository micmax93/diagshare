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


function popupWindow(title, url) {
    var newWindow = window.open(url, title, 'height=400,width=400,toolbar=no,scrollbars=no,location=no,resizable =yes');
    if (window.focus) {
        newWindow.focus()
    }
    return false;
}
