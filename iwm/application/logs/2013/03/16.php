<?php defined('SYSPATH') OR die('No direct script access.'); ?>

2013-03-16 14:08:56 --- ERROR: Database_Exception [ 1146 ]: Table 'iwm.users' doesn't exist [ SHOW FULL COLUMNS FROM `users` ] ~ MODPATH/database/classes/kohana/database/mysql.php [ 194 ]
2013-03-16 14:08:56 --- STRACE: Database_Exception [ 1146 ]: Table 'iwm.users' doesn't exist [ SHOW FULL COLUMNS FROM `users` ] ~ MODPATH/database/classes/kohana/database/mysql.php [ 194 ]
--
#0 /home/phisikus/Git/diagshare/iwm/modules/database/classes/kohana/database/mysql.php(358): Kohana_Database_MySQL->query(1, 'SHOW FULL COLUM...', false)
#1 /home/phisikus/Git/diagshare/iwm/modules/orm/classes/kohana/orm.php(1538): Kohana_Database_MySQL->list_columns('users')
#2 /home/phisikus/Git/diagshare/iwm/modules/orm/classes/kohana/orm.php(392): Kohana_ORM->list_columns()
#3 /home/phisikus/Git/diagshare/iwm/modules/orm/classes/kohana/orm.php(337): Kohana_ORM->reload_columns()
#4 /home/phisikus/Git/diagshare/iwm/modules/orm/classes/kohana/orm.php(246): Kohana_ORM->_initialize()
#5 /home/phisikus/Git/diagshare/iwm/application/classes/controller/test.php(26): Kohana_ORM->__construct()
#6 [internal function]: Controller_Test->action_index()
#7 /home/phisikus/Git/diagshare/iwm/system/classes/kohana/request/client/internal.php(116): ReflectionMethod->invoke(Object(Controller_Test))
#8 /home/phisikus/Git/diagshare/iwm/system/classes/kohana/request/client.php(64): Kohana_Request_Client_Internal->execute_request(Object(Request))
#9 /home/phisikus/Git/diagshare/iwm/system/classes/kohana/request.php(1154): Kohana_Request_Client->execute(Object(Request))
#10 /home/phisikus/Git/diagshare/iwm/index.php(109): Kohana_Request->execute()
#11 {main}