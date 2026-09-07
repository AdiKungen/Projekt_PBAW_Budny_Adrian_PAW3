<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\Validator;
use app\forms\LoginForm;
use core\OrderUtils;

class SignUpCtrl {

    private $form;
    private $users;
    private $lastid;

    public function __construct() {
        $this->form = new LoginForm();
    }

    public function validate() {

        $v = new Validator();

        $this->form->login = $v->validateFromPost('login', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj nazwę użytkownika',
            'min_length' => 2,
            'max_length' => 15,
            'validator_message' => 'Nazwa użytkownika powinna mieć od 2 do 15 znaków'
        ]);

        $this->form->pass1 = $v->validateFromPost('pass1', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj hasło',
            'min_length' => 2,
            'max_length' => 20,
            'validator_message' => 'Hasło powinno mieć od 2 do 20 znaków'
        ]);

        $this->form->pass2 = $v->validateFromPost('pass2', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj ponownie hasło',
            //'min_length' => 2,
            //'max_length' => 20,
            //'validator_message' => 'Musisz podać ponownie hasło'
        ]);

        if (App::getMessages()->isError())
            return false;

        if($this->form->pass1 != $this->form->pass2) {
            Utils::addErrorMessage('Podane hasła nie zgadzają się');
            return false;
        }

        try {
            $this->users = App::getDB()->get("users", ["login"], ["login" => $this->form->login]);
            if(isset($this->users)) {
                Utils::addErrorMessage('Istnieje już użytkownik o podanej nazwie');
                return false;
            }
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
            return false;
        }

        try {
            App::getDB()->insert("users", ["login" => $this->form->login, "password" => password_hash($this->form->pass1, PASSWORD_BCRYPT)]);
            $lastid = App::getDB()->id();
            App::getDB()->update("users", ["whoCreated" => $lastid, "whoLastModified" => $lastid], ["iduser[=]" => $lastid]);
            App::getDB()->insert("permission", ["users_iduser" => $lastid, "role_idrole" => 1]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
            return false;
        }

        return !App::getMessages()->isError();
    }

    public function action_signupShow() {
        $this->generateView();
    }

    public function action_signup() {
        if ($this->validate()) {
            Utils::addInfoMessage('Poprawnie zarejestrowano się');
            $this->generateView();
        } else {
            $this->generateView();
        }
    }

    public function generateView() {
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->display('SignUpView.tpl');
    }

}
