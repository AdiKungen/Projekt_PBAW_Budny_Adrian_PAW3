<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\SessionUtils;
use core\ParamUtils;
use app\forms\ShopForm;
use app\forms\ShopSearchForm;
use core\OrderUtils;

class ShopCtrl {

    private $form;
    private $sform;
    private $genres;
    private $cart;
    private $nowyarray;
    private $liczbastron;

    public function __construct() {
        $this->form = new ShopForm();
        $this->sform = new ShopSearchForm();
    }

    public function validate() {
        $this->sform->genre = ParamUtils::getFromRequest('genre');

        return !App::getMessages()->isError();
    }

    public function validateShop() {
        $this->form->howlong = ParamUtils::getFromRequest('howlong');

        if(isset($this->form->howlong) && $this->form->howlong <= 48 && $this->form->howlong >= 1) {
            return true;
        } else {
            return false;
        }
    }

    public function calculateCart() {
        try {
            $rentid = App::getDB()->select("rental", "idrental", ["user_iduser" => SessionUtils::load("userid", true), "issent" => NULL]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        if(!empty($rentid)) {

            try {
                $songPrice = App::getDB()->select("list", ["[><]song" => ["list.song_idsong" => "idsong"]] ,["price"], ["rental_idrental" => $rentid]);
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }

            $cartPrice = 0;
            foreach($songPrice as $s) {
                $cartPrice = $cartPrice + $s['price'];
            }

            return $cartPrice;
        } else {
            return 0;
        }
    }

    public function action_deleteCart() {
        $delsongid = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');

        try {
            $deletion = App::getDB()->select("rental", ["idrental"], ["issent" => NULL, "isaccepted" => NULL, "user_iduser" => SessionUtils::load("userid", true)]);
            foreach($deletion as $d) {
                App::getDB()->delete("list", ["rental_idrental" => $d["idrental"], "song_idsong" => $delsongid]);
                $rentalId = $d["idrental"];
            }
            $deletionList = App::getDB()->select("list", ["idlist"], ["rental_idrental" => $rentalId]);
            if(empty($deletionList)) {
                App::getDB()->delete("rental", ["idrental" => $rentalId]);
            }
            
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        App::getRouter()->redirectTo('shopShow/1');
    }

    public function action_orderCart() {
        if($this->validateShop()) {
            try {
                $cena = 0;
                $cenaSearch = App::getDB()->select("list", ["[><]song" => ["list.song_idsong" => "idsong"], "[><]rental" => ["list.rental_idrental" => "idrental"]] ,["price"], ["issent" => NULL, "isaccepted" => NULL, "user_iduser" => SessionUtils::load("userid", true)]);
                foreach($cenaSearch as $l) {
                    $cena += $l['price'];
                }
                App::getDB()->update("rental", ["issent" => 1, "howlong" => $this->form->howlong, "cost" => ($cena * $this->form->howlong)], ["issent" => NULL, "isaccepted" => NULL, "user_iduser" => SessionUtils::load("userid", true)]);
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }
            Utils::addInfoMessage('Poprawnie wysłano zamówienie');
            SessionUtils::storeMessages();
        } else {
            Utils::addErrorMessage('Niepoprawna długość wypożyczenia');
            SessionUtils::storeMessages();
        }
        App::getRouter()->redirectTo('shopShow/1');
    }

    public function action_addToOrder() {
        $songid = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');

        try {
            $rentalCheck = App::getDB()->get("rental", ["idrental"], ["user_iduser" => SessionUtils::load("userid", true), "issent" => NULL]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        
        if(!empty($rentalCheck)) {
            $rentalid = $rentalCheck["idrental"];
        } else {
            $rentalid = "";
        }
        

        if(empty($rentalid)) {
            try {
                App::getDB()->insert("rental",["user_iduser" => SessionUtils::load("userid", true)]);
                $lastid = App::getDB()->id();
                App::getDB()->insert("list",["idlist" => "", "rental_idrental" => $lastid, "song_idsong" => $songid]);
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug)
                    Utils::addErrorMessage($e->getMessage());
            }
        } else {
            try {
                App::getDB()->insert("list",["idlist" => "", "rental_idrental" => $rentalid, "song_idsong" => $songid]);
            } catch (\PDOException $e) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
            }
        }
        App::getRouter()->redirectTo('shopShow/1');
    }

    public function loadData() {
        $this->validate();

        $search_params = [];
        if (isset($this->sform->genre) && strlen($this->sform->genre) > 0) {
            $search_params['name[~]'] = $this->sform->genre . '%';
        }

        $num_params = sizeof($search_params);
        if ($num_params > 1) {
            $where = ["AND" => &$search_params];
        } else {
            $where = &$search_params;
        }

        $where ["ORDER"] = "idsong";

        try {
            $this->genres = App::getDB()->select("genre", ["name"]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        try {
            $this->cart = App::getDB()->select("song", ["[><]list" => ["song.idsong" => "song_idsong"], "[><]rental" => ["list.rental_idrental" => "idrental"]],["song.idsong", "song.artist", "song.title", "song.price", "rental.idrental"], ["user_iduser" => SessionUtils::load("userid", true), "issent" => NULL]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        try {
            $records = App::getDB()->select("song", ["[><]genre" => ["song.genre_idgenre" => "idgenre"]],["song.idsong", "song.artist", "song.title", "genre.name", "song.price", "song.whenpublished", "song.isavailable", "song.file", "song.cover"], $where);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        try {
            $precords = App::getDB()->select("song", ["[><]genre" => ["song.genre_idgenre" => "idgenre"], "[><]list" => ["song.idsong" => "song_idsong"], "[><]rental" => ["list.rental_idrental" => "idrental"]],["song.idsong", "song.artist", "song.title", "genre.name", "song.price", "song.whenpublished", "song.isavailable", "song.file", "song.cover"], ["AND" => ["user_iduser" => SessionUtils::load("userid", true), "OR" => ["whenends[>]" => date('Y-m-d H:i:s', time()), "isaccepted" => NULL]]]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }

        foreach($records as $i => $r) {
            foreach($precords as $p) {
                if($r["idsong"] == $p["idsong"]) {
                    unset($records[$i]);
                }
            }
        }
 
        $liczbawynikow = 5;  

        $strona = ParamUtils::getFromCleanURL(1, true, 'Błędne wywołanie aplikacji');

        $offset = ($strona - 1) * $liczbawynikow;

        $iloscrekordow = 0;
    
        $this->nowyarray = array();

        foreach($records as $c) {
            $this->nowyarray[] = $c;
            $iloscrekordow++;
        }

        $this->liczbastron = ceil($iloscrekordow / $liczbawynikow);

        foreach($this->nowyarray as $d => $a) {
            if($d == $offset) {
                break;
            } else {
                unset($this->nowyarray[$d]);
            }
        }

        foreach($this->nowyarray as $o => $b) {
            if($o >= 5+$offset) {
                unset($this->nowyarray[$o]);
            }
        }
    }

    public function action_shopShow() {
        $this->loadData();
        
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('cost', $this->calculateCart());
        App::getSmarty()->assign('liczbastron', $this->liczbastron);
        App::getSmarty()->assign('searchForm', $this->sform->genre);
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));
        App::getSmarty()->assign('records', $this->nowyarray);
        App::getSmarty()->assign('cart', $this->cart);
        App::getSmarty()->assign('genres', $this->genres);     
        App::getSmarty()->display("ShopView.tpl"); 
    }

    public function action_shopShowTable() {
        $this->loadData();
        
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('cost', $this->calculateCart());
        App::getSmarty()->assign('liczbastron', $this->liczbastron);
        App::getSmarty()->assign('searchForm', $this->sform->genre);
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));
        App::getSmarty()->assign('records', $this->nowyarray);
        App::getSmarty()->assign('cart', $this->cart);
        App::getSmarty()->assign('genres', $this->genres);     
        App::getSmarty()->display("ShopViewTable.tpl"); 
    }
}