<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use core\Validator;
use app\forms\UserEditForm;
use core\OrderUtils;

class UserEditCtrl {

    private $form;

    public function __construct() {
        $this->form = new UserEditForm();
    }

    public function doesPermissionExist($id, $rolename) {
        try {
            $roles = App::getDB()->select("permission", ["[><]role" => ["permission.role_idrole" => "idrole"]], ["idrole", "name"], ["users_iduser" => $id, "name" => $rolename]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        if(!empty($roles)) {
            return true;
        } else {
            return false;
        }
    }

    public function getRoleId($rolename) {
        try {
            $roles = App::getDB()->get("role", ["idrole"], ["name" => $rolename]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        if(!empty($roles)) {
            return $roles["idrole"];
        } else {
            return "";
        }
    }

    public function insertRole($chckbx, $rolename) {
        if($this->doesPermissionExist($this->form->iduser, $rolename)) {
            if(!empty($chckbx)) {
                try {
                    App::getDB()->update("permission", ["whenrevoked" => NULL], ["users_iduser" => $this->form->iduser, "role_idrole" => $this->getRoleId($rolename)]);
                } catch (\PDOException $e) {
                    Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
                    if (App::getConf()->debug)
                        Utils::addErrorMessage($e->getMessage());
                }
            } else {
                try {
                    App::getDB()->update("permission", ["whenrevoked" => date('Y-m-d H:i:s', time())], ["users_iduser" => $this->form->iduser, "role_idrole" => $this->getRoleId($rolename)]);
                } catch (\PDOException $e) {
                    Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
                    if (App::getConf()->debug)
                        Utils::addErrorMessage($e->getMessage());
                }
            }
        } else {
            if(!empty($chckbx)) {
                try {
                    App::getDB()->insert("permission", ["users_iduser" => $this->form->iduser, "role_idrole" => $this->getRoleId($rolename)]);
                } catch (\PDOException $e) {
                    Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
                    if (App::getConf()->debug)
                        Utils::addErrorMessage($e->getMessage());
                }
            }
        }
    }

    /* Walidacja danych przed zapisem (nowe dane lub edycja).
     * Poniżej pełna, możliwa konfiguracja metod walidacji:
     *  [ 
     *    'trim' => true,
     *    'required' => true,
     *    'required_message' => 'message...',
     *    'min_length' => value,
     *    'max_length' => value,
     *    'email' => true,
     *    'numeric' => true,
     *    'int' => true,
     *    'float' => true,
     *    'date_format' => format,
     *    'regexp' => expression,
     *    'validator_message' => 'message...',
     *    'message_type' => error | warning | info,
     *  ]
     */
    
    public function validateSave() {
        $this->form->iduser = ParamUtils::getFromPost('iduser', true, 'Błędne wywołanie aplikacji');
        
        if(isset($_POST['chckbxpswd'])) {
            $this->form->chckbxpswd = 1;
        }
        if(isset($_POST['chckbxadmin'])) {
            $this->form->chckbxadmin = "admin";
        }
        if(isset($_POST['chckbxuser'])) {
            $this->form->chckbxuser = "user";
        }
        if(isset($_POST['chckbxworker'])) {
            $this->form->chckbxworker = "worker";
        }
        
        $v = new Validator();

        $this->form->login = $v->validateFromPost('login', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Podaj nazwę użytkownika',
            'min_length' => 2,
            'max_length' => 15,
            'validator_message' => 'Nazwa użytkownika powinna mieć od 2 do 15 znaków'
        ]);
        
        if($this->form->chckbxpswd == 1) {
            $this->form->password = $v->validateFromPost('password', [
                'trim' => true,
                'required_message' => 'Podaj hasło',
                'min_length' => 2,
                'max_length' => 20,
                'validator_message' => 'Hasło powinno mieć od 2 do 20 znaków'
            ]);

            $this->form->apassword = $v->validateFromPost('apassword', [
                'trim' => true,
                'required_message' => 'Podaj ponownie hasło',
                'min_length' => 2,
                'max_length' => 20,
                'validator_message' => 'Musisz podać ponownie hasło'
            ]);
        } else {
            $this->form->password = $v->validateFromPost('password', [
                'trim' => true,
                'required' => true,
                'required_message' => 'Podaj hasło',
                'min_length' => 2,
                'max_length' => 20,
                'validator_message' => 'Hasło powinno mieć od 2 do 20 znaków'
            ]);

            $this->form->apassword = $v->validateFromPost('apassword', [
                'trim' => true,
                'required' => true,
                'required_message' => 'Podaj ponownie hasło',
                'min_length' => 2,
                'max_length' => 20,
                'validator_message' => 'Musisz podać ponownie hasło'
            ]);

            if($this->form->password != $this->form->apassword) {
                Utils::addErrorMessage("Hasła nie zgadzają się");
            }
        }

        try {
            $chckUsers = App::getDB()->select("users", ["login"], ["iduser[!]" => $this->form->iduser, "login" => $this->form->login]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        if(!empty($chckUsers)) {
            Utils::addErrorMessage("Użytownik o takiej nazwie już istnieje");
        }

        return !App::getMessages()->isError();
    }
    
    public function validateEdit() {
        $this->form->iduser = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');

        return !App::getMessages()->isError();
    }


    public function action_userNew() {
        $this->generateView();
    }

    public function action_userEdit() {

        if ($this->validateEdit()) {
            try {
                $record = App::getDB()->get("users", ["iduser", "login", "password"], ["iduser" => $this->form->iduser]);
                $roles = App::getDB()->select("permission", ["[><]role" => ["permission.role_idrole" => "idrole"]], ["name"], ["users_iduser" => $this->form->iduser, "whenrevoked" => NULL]);

                $this->form->iduser = $record['iduser'];
                $this->form->login = $record['login'];
                $this->form->password = $record['password'];
                
                foreach($roles as $r) {
                    if($r["name"] == "admin") {
                        $this->form->chckbxadmin = "admin";
                    } elseif($r["name"] == "user") {
                        $this->form->chckbxuser = "user";
                    } elseif($r["name"] == "worker") {
                        $this->form->chckbxworker = "worker";
                    }
                }

            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas odczytu rekordu');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }
        }

        $this->generateView();
    }

    public function action_userDelete() {
        if ($this->validateEdit()) {

            try {
                App::getDB()->delete("users", ["iduser" => $this->form->iduser]);
                Utils::addInfoMessage('Pomyślnie usunięto rekord');
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas usuwania rekordu');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }
        }

        App::getRouter()->forwardTo('userList');
    }

    
    public function action_userSave() {

        if ($this->validateSave()) {
            try {
                if ($this->form->iduser == '') {

                    $count = App::getDB()->count("users");
                    if ($count <= 20) {
                        App::getDB()->insert("users", ["login" => $this->form->login,"password" => password_hash($this->form->password, PASSWORD_BCRYPT), "whocreated" => SessionUtils::load("userid", true),"wholastmodified" => SessionUtils::load("userid", true)]);
                        $idinsert = App::getDB()->id();
                        if(!empty($this->form->chckbxadmin)) {
                            App::getDB()->insert("permission", ["users_iduser" => $idinsert, "role_idrole" => $this->getRoleId($this->form->chckbxadmin)]);
                        }
                        if(!empty($this->form->chckbxuser)) {
                            App::getDB()->insert("permission", ["users_iduser" => $idinsert, "role_idrole" => $this->getRoleId($this->form->chckbxuser)]);
                        }
                        if(!empty($this->form->chckbxworker)) {
                            App::getDB()->insert("permission", ["users_iduser" => $idinsert, "role_idrole" => $this->getRoleId($this->form->chckbxworker)]);
                        }
                    } else {
                        Utils::addInfoMessage('Ograniczenie: Zbyt dużo rekordów. Aby dodać nowy usuń wybrany wpis.');
                        $this->generateView();
                        exit();
                    }
                } else {
                    if($this->form->chckbxpswd == 1){
                        App::getDB()->update("users", ["login" => $this->form->login, "wholastmodified" => SessionUtils::load("userid", true)], ["iduser" => $this->form->iduser]);
                    } else {
                        App::getDB()->update("users", ["login" => $this->form->login, "password" => password_hash($this->form->password, PASSWORD_BCRYPT), "wholastmodified" => SessionUtils::load("userid", true)], ["iduser" => $this->form->iduser]);
                    }

                    $this->insertRole($this->form->chckbxadmin, "admin");
                    $this->insertRole($this->form->chckbxuser, "user");
                    $this->insertRole($this->form->chckbxworker, "worker");

                }
                Utils::addInfoMessage('Pomyślnie zapisano rekord');
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił nieoczekiwany błąd podczas zapisu rekordu');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }

            App::getRouter()->forwardTo('userList');
        } else {
            $this->generateView();
        }
    }

    public function generateView() {
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->display('UserEditView.tpl');
    }

}
