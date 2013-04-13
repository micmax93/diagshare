<?php
/**
 * Created by JetBrains PhpStorm.
 * User: phisikus
 * Date: 13.04.13
 * Time: 21:40
 * To change this template use File | Settings | File Templates.
 */

require("IwMController.php");
class Controller_User extends IwMController
{
    public function action_index()
    {

    }

    public function action_login()
    {

        $widok = View::factory('login');
        $widok->set('title', 'DiagShare');

        $this->response->body($widok->render());
    }


    public function action_authorize()
    {
        //$user = $muser->getUserByUsername('admin');
        //$mrole = new Model_Role();
        //$muser->setUserProfile(0,"admin","admin@admin.pl","Administrator","admin");
        //$mrole->setRoleProfile(0,"login","Podstawowa rola umożliwiająca logowanie");
        //$user->addRole('login');
        ;
        //$this->request->post('password');
        $muser = new Model_User();

        $res["status"] = $this->request->post('username');
        $this->response->headers('Content-Type', 'application/json');
        $this->response->body(json_encode($res));
    }

    public function action_authorized()
    {
        $this->request->redirect('/');
    }


    public function action_logout()
    {
        Auth::instance()->logout();
        $this->request->redirect('user/login');
    }
}