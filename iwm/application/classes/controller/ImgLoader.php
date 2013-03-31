<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 30.03.13
 */
class Controller_ImgLoader
{
    public $part_max_size=300;
    public $part_min_size=200;

    public function printForm()
    {
        echo '<form enctype="multipart/form-data" method="post">
                <input type="text" size="32" name="img_title" placeholder="title"><br>
                <input type="file" size="32" name="img_upload" value=""><br>
                <input type="submit" name="Wyślij">
                </form>';
    }
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
        if(isset($_FILES['img_upload']))
        {
            $f = $_FILES['img_upload'];
            if(isset($f['name']))
            {
                if(($f['size']>0)&&($f['error']==0)) {return true;}
            }
        }
        return false;
    }
    public function loadAsImg()
    {
        $f = $_FILES['img_upload'];
        if($f['type'] == 'image/png')
        {
            $img=@imagecreatefrompng($f['tmp_name']);
            if(!$img) {return null;}
            else {return $img;}
        }
        else if($f['type'] == 'image/jpeg')
        {
            $img=@imagecreatefromjpeg($f['tmp_name']);
            if(!$img) {return null;}
            else {return $img;}
        }
        else if($f['type'] == 'image/gif')
        {
            $img=@imagecreatefromgif($f['tmp_name']);
            if(!$img) {return null;}
            else {return $img;}
        }
        else
        {
            return null;
        }
    }

    public function calcParts($size)
    {
        $max=floor($size/$this->part_min_size);
        $min=floor($size/$this->part_max_size);
        if($min==0) {$min=1;}
        $result['dif']=1;
        $result['num']=1;
        for($i=$min;$i<=$max;$i++)
        {
            $part=$size/$i;
            $dif=abs($part-round($part));
            //echo "<br>" . $i . " " . $dif;
            if($dif<=$result['dif'])
            {
                $result['dif']=$dif;
                $result['num']=$i;
                $result['part']=round($part);
                $result['recal']=($i*round($part))-$size;
                $result['out']=($i*round($part));
            }
        }
        return $result;
    }

    public function calcImgSplit($img)
    {
        $img_data['x']=$this->calcParts(@imagesx($img));
        $img_data['y']=$this->calcParts(@imagesy($img));
        $img_data['img']=@imagecreatetruecolor($img_data['x']['out'],$img_data['y']['out']);
        @imagecopyresampled($img_data['img'],$img,0,0,0,0,$img_data['x']['out'],$img_data['y']['out'],@imagesx($img),@imagesy($img));
        return $img_data;
    }

    public function newPhoto($img_data)
    {
        $photo=new Model_Photos();
        $photo->title='NPhoto';
        $photo->x_count=$img_data['x']['num'];
        $photo->y_count=$img_data['y']['num'];
        $photo->width=$img_data['x']['out'];
        $photo->height=$img_data['y']['out'];
        $photo->filename=$_FILES['img_upload']['name'];
        return $photo->save();
    }

    public function splitSaveImg($path,$img_data)
    {
        mkdir($path);
        @imagepng($img_data['img'],$path . $_FILES['img_upload']['name'] . '.png');

        $row_size=$img_data['x']['num'];
        $p_width=$img_data['x']['part'];
        $p_height=$img_data['y']['part'];

        for($y=0;$y<$img_data['y']['num'];$y++)
        {
            for($x=0;$x<$img_data['x']['num'];$x++)
            {
                $prt=@imagecreatetruecolor($p_width,$p_height);
                @imagecopy($prt,$img_data['img'],0,0,$x*$p_width,$y*$p_height,$p_width,$p_height);
                if(@imagepng($prt,$path . ($x+$y*$row_size).".png")) {echo "OK ";}
                else {echo "BAD ";}
            }
        }
    }

    public function action_test()
    {
        if(!$this->isLoaded())
        {
            $this->printForm();
        }
        else
        {
            $this->printInfo();
            $img = $this->loadAsImg();
            if($img!=null)
            {
                echo "<br>original size= " . @imagesx($img) . " x " . @imagesy($img);

                $img_data=$this->calcImgSplit($img);

                echo "<br>resize= " . $img_data['x']['out'] . " x " . $img_data['y']['out'];
                echo "  correction(" . $img_data['x']['recal'] . "," . $img_data['y']['recal'] . ") ";

                echo "<br>part count= " . $img_data['x']['num'] . " x " . $img_data['y']['num'];
                echo "<br>part size= " . $img_data['x']['part'] . " x " . $img_data['y']['part'];
                echo "<br>Loading progres:";

                //$photo=$this->newPhoto($img_data);
                //$path=$photo->getRelPath();
                $path='application/views/img/grids/'.$_FILES['img_upload']['name'].'/';
                $this->splitSaveImg($path,$img_data);
            }
            else
            {
                echo "Load failed";
            }
        }
        $path=url::base(TRUE, 'http') . 'application/views/img/';

    }
}
