<?php

namespace app\controllers;

use core\App;
use core\SessionUtils;
use core\OrderUtils;

class HomeCtrl {
    
    public function action_homeShow() {
        App::getSmarty()->assign('isOrder', OrderUtils::isOrder());
        App::getSmarty()->assign('nazwa', SessionUtils::load("nazwa", true));     
        App::getSmarty()->display("HomeView.tpl"); 
    }
}
