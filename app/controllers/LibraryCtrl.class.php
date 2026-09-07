<?php

namespace app\controllers;

use core\App;
use core\SessionUtils;
use core\Utils;
use core\OrderUtils;

class LibraryCtrl {
    
    public function action_libraryShow() { 
        try {
            $records = App::getDB()->select("song", ["[><]genre" => ["song.genre_idgenre" => "idgenre"], "[><]list" => ["song.idsong" => "song_idsong"], "[><]rental" => ["list.rental_idrental" => "idrental"]],["song.idsong", "song.artist", "song.title", "genre.name", "song.price", "song.whenpublished", "song.isavailable", "song.file", "song.cover", "rental.whenends"], ["user_iduser" => SessionUtils::load("userid", true), "rental.issent" => 1, "rental.isaccepted" => 1, "rental.whenends[>]" => date('Y-m-d H:i:s', time())]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        if(!empty($records)) {
            foreach($records as $r) {
                if(!isset($min)) {
                    $min = $r['whenends'];
                } else if ($r['whenends'] < $min) {
                    $min = $r['whenends'];
                }
            }
            $numOfSeconds = (strtotime($min)+1) - strtotime(date('Y-m-d H:i:s', time()));

            header( "refresh:$numOfSeconds" );
        }

        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('records', $records);
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));     
        App::getSmarty()->display("LibraryView.tpl"); 
    }
}