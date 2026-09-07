<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use app\forms\UserSearchForm;
use core\OrderUtils;

class UserListCtrl {

    private $form;
    private $records;
    private $precords;

    public function __construct() {
        $this->form = new UserSearchForm();
    }

    public function validate() {
        $this->form->login = ParamUtils::getFromRequest('login');

        return !App::getMessages()->isError();
    }

    public function load_data() {
        $this->validate();

        $search_params = [];
        if (isset($this->form->login) && strlen($this->form->login) > 0) {
            $search_params['login[~]'] = $this->form->login . '%';
        }

        $num_params = sizeof($search_params);
        if ($num_params > 1) {
            $where = ["AND" => &$search_params];
        } else {
            $where = &$search_params;
        }

        try {
            $this->precords = App::getDB()->select("users", ["[><]permission" => ["users.iduser" => "users_iduser"], "[><]role" => ["permission.role_idrole" => "idrole"]], ["iduser", "name"], ["whenrevoked" => NULL]);
            $this->records = App::getDB()->select("users", ["iduser", "login", "password"], $where);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

    }

    public function action_userList() {
        $this->load_data();
        
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));  
        App::getSmarty()->assign('searchForm', $this->form);
        App::getSmarty()->assign('users', $this->records);
        App::getSmarty()->assign('pusers', $this->precords);
        App::getSmarty()->display('UserListView.tpl');
    }

    public function action_userListTable() {
        $this->load_data();

        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true)); 
        App::getSmarty()->assign('searchForm', $this->form);
        App::getSmarty()->assign('users', $this->records);
        App::getSmarty()->assign('pusers', $this->precords);
        App::getSmarty()->display('UserListTable.tpl');
    }
}
