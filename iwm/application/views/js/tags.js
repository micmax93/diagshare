/**
 * Created with JetBrains PhpStorm.
 * User: phisikus
 * Date: 06.04.13
 * Time: 13:34
 * To change this template use File | Settings | File Templates.
 */

function addTag(parentId, top, left, content) {
    $('#' + parentId).append('<div class="imageTag">Elo</div>');
    $('#' + parentId + ' > .imageTag').draggable({opacity: 0.6});
}