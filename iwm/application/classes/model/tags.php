<?php
/**
 * Created by JetBrains PhpStorm.
 * User: micmax93
 * Date: 18.03.13
 */
class Model_Tags extends Model_Base
{
    public $_table_name = "tags";

    public function getAllItemsForPhoto($id)
    {
        return ORM::factory('tags')->where('photo_id', '=', $id)->find_all();
    }

    public function setTag($arr)
    {
        if ($arr["id"] != 0) {
            if (ORM::factory('tags')->where('id', '=', $arr["id"])->count_all() == 0) return -1;
            $tag = ORM::factory('tags')->where('id', '=', $arr["id"])->find();
        } else
            $tag = ORM::factory('tags');
        foreach ($arr as $k => $v) {
            if ($k != "id")
                $tag->$k = $v;
        }
        $tag->save();
        return $tag->id;
    }

    public function getOwner()
    {
        $u = new Model_User();
        return $u->getItem($this->owner_id);
    }

    public function getPhoto()
    {
        $p = new Model_Photos();
        return $p->getItem($this->photoId);
    }


    public function myPosts()
    {
        $p = new Model_Posts();
        return $p->newQuery()->where('tag_id', '=', $this->id)->find_all();
    }

    public function getAllPostsAfter($lastPost)
    {
        $p = new Model_Posts();

        $p = $p->newQuery();
        $p = $p->where('tag_id', '=', $this->id);
        $p = $p->where('id', '>', $lastPost);
        $p = $p->order_by('id', 'ASC');

        return $p->find_all();
    }

    public function deleteItem($id)
    {
        if (ORM::factory('tags')->where('id', '=', $id)->count_all() == 0) return false;
        $tag = ORM::factory('tags')->where('id', '=', $id)->find();
        if (count($tag) == 0) return false;
        $posts = $tag->myPosts();
        foreach ($posts as $post) {
            $post->delete();
        }
        $tag->delete();
        return true;
    }
}
