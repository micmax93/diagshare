<?php defined('SYSPATH') OR die('No direct script access.'); ?>

2013-03-12 13:20:30 --- EMERGENCY: ErrorException [ 2 ]: Missing argument 1 for Controller_Welcome::action_lol(), called in /var/www/iwm/system/classes/Kohana/Controller.php on line 84 and defined ~ APPPATH/classes/Controller/Welcome.php [ 11 ] in /var/www/iwm/application/classes/Controller/Welcome.php:11
2013-03-12 13:20:30 --- DEBUG: #0 /var/www/iwm/application/classes/Controller/Welcome.php(11): Kohana_Core::error_handler(2, 'Missing argumen...', '/var/www/iwm/ap...', 11, Array)
#1 /var/www/iwm/system/classes/Kohana/Controller.php(84): Controller_Welcome->action_lol()
#2 [internal function]: Kohana_Controller->execute()
#3 /var/www/iwm/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Welcome))
#4 /var/www/iwm/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#5 /var/www/iwm/system/classes/Kohana/Request.php(990): Kohana_Request_Client->execute(Object(Request))
#6 /var/www/iwm/index.php(118): Kohana_Request->execute()
#7 {main} in /var/www/iwm/application/classes/Controller/Welcome.php:11
2013-03-12 13:24:11 --- EMERGENCY: ErrorException [ 8 ]: Undefined variable: tresc ~ APPPATH/views/index.php [ 17 ] in /var/www/iwm/application/views/index.php:17
2013-03-12 13:24:11 --- DEBUG: #0 /var/www/iwm/application/views/index.php(17): Kohana_Core::error_handler(8, 'Undefined varia...', '/var/www/iwm/ap...', 17, Array)
#1 /var/www/iwm/system/classes/Kohana/View.php(61): include('/var/www/iwm/ap...')
#2 /var/www/iwm/system/classes/Kohana/View.php(348): Kohana_View::capture('/var/www/iwm/ap...', Array)
#3 /var/www/iwm/application/classes/Controller/Welcome.php(10): Kohana_View->render()
#4 /var/www/iwm/system/classes/Kohana/Controller.php(84): Controller_Welcome->action_index()
#5 [internal function]: Kohana_Controller->execute()
#6 /var/www/iwm/system/classes/Kohana/Request/Client/Internal.php(97): ReflectionMethod->invoke(Object(Controller_Welcome))
#7 /var/www/iwm/system/classes/Kohana/Request/Client.php(114): Kohana_Request_Client_Internal->execute_request(Object(Request), Object(Response))
#8 /var/www/iwm/system/classes/Kohana/Request.php(990): Kohana_Request_Client->execute(Object(Request))
#9 /var/www/iwm/index.php(118): Kohana_Request->execute()
#10 {main} in /var/www/iwm/application/views/index.php:17