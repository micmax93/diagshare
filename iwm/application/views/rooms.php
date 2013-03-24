<?php
/**
 * Created by: Marcin Biernacki <phisikus@platinum.linux.pl>
 * User: phisikus
 * Date: 15.03.13
 */


echo '
<p>
Pokoje
</p>
<ul id="rooms">

</ul>
<br>
    <script type="text/javascript">
    var data;
        $.ajax({
            dataType: "json",
            url: "'.url::base(TRUE, 'http').'index.php/room/get",
            data: data,
            success: roomsReceived
        });
    </script>

';

echo '

';