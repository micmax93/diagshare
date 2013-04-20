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

    public function setTag($id, $photoId, $ownerId, $title, $x, $y)
    {
        if ($id != 0)
            $tag = ORM::factory('tags')->where('id', '=', $id)->find();
        else
            $tag = ORM::factory('tags');

        $tag->photo_id = $photoId;
        $tag->owner_id = $ownerId;
        $tag->title = $title;
        $tag->x = $x;
        $tag->y = $y;
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
