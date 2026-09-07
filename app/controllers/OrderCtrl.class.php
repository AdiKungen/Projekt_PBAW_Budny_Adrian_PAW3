<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\SessionUtils;
use core\ParamUtils;
use app\forms\AcceptForm;
use core\OrderUtils;

class OrderCtrl {

    private $form;

    public function __construct() {
        $this->form = new AcceptForm();
    }

    public function validateAccept() {
        $this->form->chckbx = ParamUtils::getFromPost('chckbx');

        if(isset($this->form->chckbx)) {
            return true;
        } else {
            return false;
        }
    }

    public function action_acceptOrder() {
        $rentid = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');
        $showlong = App::getDB()->get("rental", ["howlong"], ["idrental" => $rentid]);

        $howlong = intval($showlong["howlong"]);

        if($this->validateAccept()) {
            App::getDB()->update("rental", ["isaccepted" => 1, "whenrented" => date('Y-m-d H:i:s', time()), "whenends" => date('Y-m-d H:i:s', (time() + ($howlong*3600)))], ["idrental" => $rentid]);
            Utils::addInfoMessage('Poprawnie zaakceptowano zamówienie');
        } else {
            Utils::addErrorMessage('Użytkownik nie uiścił zapłaty za zamówienie');
        }
        SessionUtils::storeMessages();
        App::getRouter()->redirectTo('orderShow');
    }

    public function action_detailOrder() {
        $orderid = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');

        try {
            $details = App::getDB()->select("list", ["[><]song" => ["list.song_idsong" => "idsong"], "[><]genre" => ["song.genre_idgenre" => "idgenre"], "[><]rental" => ["list.rental_idrental" => "idrental"], "[><]users" => ["rental.user_iduser" => "iduser"]], ["song.idsong", "song.artist", "song.title", "genre.name", "song.price", "song.whenpublished", "song.isavailable", "song.file", "song.cover", "list.rental_idrental", "rental.howlong", "rental.cost", "users.login"], ["list.rental_idrental" => $orderid]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        SessionUtils::storeObject("details", $details);
        App::getRouter()->redirectTo('orderShow');
    }

    public function action_orderShow() {
        $this->generateView();
    }

    public function generateView() {
        try {
            $orders = App::getDB()->select("rental", ["idrental"], ["issent" => 1, "isaccepted" => NULL]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('details', SessionUtils::loadObject("details"));
        App::getSmarty()->assign('orders', $orders);
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));
        App::getSmarty()->display("OrderView.tpl"); 
    }
}