/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 27.04.13
 * Time: 16:43
 * To change this template use File | Settings | File Templates.
 */

function saveView()
{
    var data = Array();
    data["status"] = "PUBLIC";
    data["state"] = JSON.stringify(getBoardState());
    jQuery.post(baseUrl + "index.php/view/set/0", data,function(v) { });
}