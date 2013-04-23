<?php
/**
 * Created by Yongo Group
 * User: phisikus
 * Date: 26.03.13
 * Time: 13:16
 */

require("IwMController.php");
require("websocket.php");

class Controller_Image extends IwMController
{


    public function action_get()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);

        $photos = new Model_Photos();
        $image = $photos->getItem($id)->getLinkArray();
        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($image));
    }

    public function action_delete()
    {
        $id = $this->request->param("id");
        preg_replace('/[\s\W]+/', '-', $id);
        $photos = new Model_Photos();
        $photos->deletePhoto($id);

        if ($photos->deletePhoto($id)) {
            $res = array("status" => "ok");
            WebSocketBroadcastAdmin::single_update('room', 0);
        } else {
            $res = array("status" => "failed");
        }

        $this->response->headers('Access-Control-Allow-Origin', '*');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($res));
    }

    /**
     * Funkcje pomocnicze
     */

    public $part_max_size = 300;
    public $part_min_size = 200;


    public function printInfo()
    {
        echo '<pre>';
        print_r($_POST);
        echo '<HR>';
        print_r($_FILES);
        echo '</pre>';
    }

    public function isLoaded()
    {
        if (isset($_FILES['img_upload']) and isset($_POST['img_title'])) {
            $f = $_FILES['img_upload'];
            if (isset($f['name'])) {
                if (($f['size'] > 0) && ($f['error'] == 0)) {
                    return true;
                }
            }
        }
        return false;
    }

    public function loadAsImg()
    {
        $f = $_FILES['img_upload'];
        if ($f['type'] == 'image/png') {
            $img = @imagecreatefrompng($f['tmp_name']);
            if (!$img) {
                return null;
            } else {
                return $img;
            }
        } else if ($f['type'] == 'image/jpeg') {
            $img = @imagecreatefromjpeg($f['tmp_name']);
            if (!$img) {
                return null;
            } else {
                return $img;
            }
        } else if ($f['type'] == 'image/gif') {
            $img = @imagecreatefromgif($f['tmp_name']);
            if (!$img) {
                return null;
            } else {
                return $img;
            }
        } else {
            return null;
        }
    }

    public function calcParts($size)
    {
        $max = floor($size / $this->part_min_size);
        $min = floor($size / $this->part_max_size);
        if ($min == 0) {
            $min = 1;
        }
        $result['dif'] = 1;
        $result['num'] = 1;
        for ($i = $min; $i <= $max; $i++) {
            $part = $size / $i;
            $dif = abs($part - round($part));
            //echo "<br>" . $i . " " . $dif;
            if ($dif <= $result['dif']) {
                $result['dif'] = $dif;
                $result['num'] = $i;
                $result['part'] = round($part);
                $result['recal'] = ($i * round($part)) - $size;
                $result['out'] = ($i * round($part));
            }
        }
        return $result;
    }

    public function calcImgSplit($img)
    {
        $img_data['x'] = $this->calcParts(@imagesx($img));
        $img_data['y'] = $this->calcParts(@imagesy($img));
        $img_data['img'] = @imagecreatetruecolor($img_data['x']['out'], $img_data['y']['out']);
        @imagecopyresampled($img_data['img'], $img, 0, 0, 0, 0, $img_data['x']['out'], $img_data['y']['out'], @imagesx($img), @imagesy($img));
        return $img_data;
    }


    public function splitSaveImg($path, $img_data)
    {
        mkdir($path);
        @imagepng($img_data['img'], $path . $_FILES['img_upload']['name'] . '.png');

        $row_size = $img_data['x']['num'];
        $p_width = $img_data['x']['part'];
        $p_height = $img_data['y']['part'];

        for ($y = 0; $y < $img_data['y']['num']; $y++) {
            for ($x = 0; $x < $img_data['x']['num']; $x++) {
                $prt = @imagecreatetruecolor($p_width, $p_height);
                @imagecopy($prt, $img_data['img'], 0, 0, $x * $p_width, $y * $p_height, $p_width, $p_height);
                if (@imagepng($prt, $path . ($x + $y * $row_size) . ".png")) {
                    //echo "OK ";
                } else {
                    //echo "BAD ";
                    return false;
                }
            }
        }
        return true;
    }

    public function action_load()
    {

        $widok = View::factory('loadimg');

        if (!$this->isLoaded()) {

            $id = $this->request->param("id");
            preg_replace('/[\s\W]+/', '-', $id);

            $widok->set('patientId', $id);
            $this->response->body($widok->render());

        } else {
            $widok->set('loading', 0);
            //$this->printInfo();
            $img = $this->loadAsImg();
            if ($img != null) {
                //  echo "<br>original size= " . @imagesx($img) . " x " . @imagesy($img);

                $img_data = $this->calcImgSplit($img);

                /* echo "<br>resize= " . $img_data['x']['out'] . " x " . $img_data['y']['out'];
                 echo "  correction(" . $img_data['x']['recal'] . "," . $img_data['y']['recal'] . ") ";

                 echo "<br>part count= " . $img_data['x']['num'] . " x " . $img_data['y']['num'];
                 echo "<br>part size= " . $img_data['x']['part'] . " x " . $img_data['y']['part'];*/

                $photoData["id"] = 0;
                $photoData["title"] = str_replace(" ", "_", $_POST['img_title']);
                $photoData["patient_id"] = $_POST['patient_id'];
                $photoData["x_count"] = $img_data['x']['num'];
                $photoData["y_count"] = $img_data['y']['num'];
                $photoData["width"] = $img_data['x']['out'];
                $photoData["height"] = $img_data['y']['out'];
                $photoData["filename"] = $_FILES['img_upload']['name'];

                $mphoto = new Model_Photos();
                $photo = $mphoto->setPhoto($photoData);
                $path = $photo->getRelPath();
                //echo "<br>Saving path: " . $path;

                //echo "<br>Loading progres:";
                $widok->set('message', '
                <script type="text/javascript">
                //    window.opener.loadRooms();
                    window.close();
                </script>
                ');
                $this->splitSaveImg($path, $img_data);
                WebSocketBroadcastAdmin::single_update('room',0);
            } else {
                $widok->set('message', "Load failed");
            }

            $this->response->body($widok->render());
        }

    }


}