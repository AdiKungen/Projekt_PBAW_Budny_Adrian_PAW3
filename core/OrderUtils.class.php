<?php

namespace core;

use core\App;

class OrderUtils {

    public static function isOrder() {
        try {
            $orders = App::getDB()->select("rental", ["idrental"], ["issent" => 1, "isaccepted" => NULL]);
        } catch (\PDOException $e) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug)
                Utils::addErrorMessage($e->getMessage());
        }
        if(!empty($orders)) {
            return true;
        } else {
            return false;
        }
    }

}
