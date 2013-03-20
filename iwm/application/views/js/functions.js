/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 16.03.13
 * Time: 00:05
 * To change this template use File | Settings | File Templates.
 */
function showHideImage(thing) {
    var el = document.getElementById(thing);
    if (el.style.display == "none") {
        el.style.display = "inline";
        el.parentNode.style.height = parseInt(el.height) + "px";

    }
    else {
        el.style.display = "none";
        el.parentNode.style.height = (parseInt(el.parentNode.style.height) - parseInt(el.height)) + "px";

    }

}