<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 17.03.13
 */
class Model_Photos extends Model_Base
{
    public $_table_name = "photos";
    public $height=100;
    public $width=100;

    public function getPatient()
    {
        $p=new Model_Patients();
        return $p->getItem($this->patient_id);
    }

    public function myViews()
    {
        $p=new Model_Views();
        return $p->newQuery()->where('photo_id','=',$this->id)->find_all();
    }

    public function getTags($begX,$begY,$endX,$endY)
    {
        $p=new Model_Tags();
        $q=$p->newQuery();

        $q=$q->where('photo_id','=',$this->id);
        $q=$q->where('x','>=',$begX);
        $q=$q->where('x','<=',$endX);
        $q=$q->where('y','>=',$begY);
        $q=$q->where('y','<=',$endY);

        $t=$q->find_all();
        return $t;
    }

    public function getLinkArray()
    {
        $img = array(
            "rowSize" => $this->x_count,
            "numberOfRows" => $this->y_count,
            "images" => array()
            );
        $path=url::base(TRUE, 'http') . 'application/views/img/' . $this->id . '.' . $this->filename . '/';
        for($i=0;$i<($this->x_count*$this->y_count);$i++)
        {
            array_push($img["images"],$path . $i . '.jpg');
        }
        return $img;
    }
}