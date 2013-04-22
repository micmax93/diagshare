<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 15.03.13
 */


echo '
<div id="rooms">
</div>
<br>
    <script type="text/javascript">
    function loadRooms()
    {
        var data;
        $.ajax({
            dataType: "json",
            url: "'.url::base(TRUE, 'http').'index.php/room/get",
            data: data,
            success: roomsReceived
        });
    }
    </script>

';

echo '

';