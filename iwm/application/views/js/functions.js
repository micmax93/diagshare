/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */

function userAuthorized(v) {
    alert(v["status"]);
    //window.location = "authorized";
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



