<?php
/**
 * Created by Yongo Group
 * User: phisikus
 * Date: 26.03.13
 * Time: 13:16
 */

require("IwMController.php");

class Controller_Image extends IwMController
{


  public function action_get()
  {
    $name = $this->request->param("id");
    preg_replace('/[\s\W]+/', '-', $name);

    $image["Zestaw1"] = array(
      "rowSize" => "3",
      "numberOfRows" => "3",
      "width" => "200",
      "height" => "200",
      "images" =>
      array(
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray2.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray3.jpg',
        url::base(TRUE, 'http') . 'application/views/img/xray.jpg',
      )

    );


    $image["Obraz1"] = array(
      "rowSize" => "1",
      "numberOfRows" => "1",
      "width" => "1050",
      "height" => "750",
      "images" => array(url::base(TRUE, 'http') . 'application/views/img/xray.jpg')
    );

    $image[$name]["name"] = $name;
    $this->response->headers('Content-Type', 'application/json');
    $this->response->body(json_encode($image[$name]));
  }

}
