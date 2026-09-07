<?php

namespace app\controllers;

use core\App;
use core\Validator;
use core\Utils;
use core\RoleUtils;
use app\forms\LoginForm;
use core\SessionUtils;
use core\OrderUtils;

class LoginCtrl {

    private $form;

    public function __construct() {
        $this->form = new LoginForm();
    }

    public function validate() {
        $v = new Validator();

        $this->form->login = $v->validateFromPost('login', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj nazwę użytkownika',
        ]);

        $this->form->pass = $v->validateFromPost('pass', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj hasło',
        ]);

        if (App::getMessages()->isError())
            return false;

        try {
            $users = App::getDB()->get("users", ["idUser","login","password"], ["login" => $this->form->login]);
            if(isset($users) && password_verify($this->form->pass, $users["password"])) {
                $perm = App::getDB()->select("role", ["[><]permission" => ["role.idrole" => "role_idrole"], "[><]users" => ["permission.users_iduser" => "iduser"]], ["role.name", "permission.whenrevoked", "role.isactive", "users.iduser"], ["users.login" => $this->form->login]);
                foreach($perm as $per) {
                    if($per['whenrevoked'] == null && $per['isactive'] == 1) {
                        SessionUtils::store('nazwa', $this->form->login);
                        SessionUtils::store('userid', $per['iduser']);
                        RoleUtils::addRole($per['name']);
                    }
                }
                if(!count(App::getConf()->roles)>0) {
                    Utils::addErrorMessage('Konto nie posiada żadnych uprawnień. Skontaktuj się z administratorem');
                    return false;
                } else {
                    return true;
                }
            }
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
            return false;
        }

        if (!App::getMessages()->isError())
            Utils::addErrorMessage('Niepoprawny login lub hasło');

        return !App::getMessages()->isError();
    }

    public function action_loginShow() {
        $this->generateView();
    }

    public function action_login() {
        if ($this->validate()) {
            Utils::addInfoMessage('Poprawnie zalogowano do systemu');
            App::getRouter()->redirectTo('homeShow');
        } else {
            $this->generateView();
        }
    }

    public function action_logout() {
        session_destroy();
        App::getRouter()->redirectTo('loginShow');
    }

    public function generateView() {
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));
        App::getSmarty()->display('LoginView.tpl');
    }

}
