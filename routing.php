<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('homeShow'); #default action
App::getRouter()->setLoginRoute('loginShow'); #action to forward if no permissions

Utils::addRoute('homeShow', 'HomeCtrl');
Utils::addRoute('login', 'LoginCtrl');
Utils::addRoute('loginShow', 'LoginCtrl');
Utils::addRoute('logout', 'LoginCtrl');
Utils::addRoute('signupShow', 'SignUpCtrl');
Utils::addRoute('signup', 'SignUpCtrl');
Utils::addRoute('shopShow', 'ShopCtrl');
Utils::addRoute('shopShowTable', 'ShopCtrl');
Utils::addRoute('addToOrder', 'ShopCtrl', ['user']);
Utils::addRoute('orderCart', 'ShopCtrl', ['user']);
Utils::addRoute('deleteCart', 'ShopCtrl', ['user']);
Utils::addRoute('orderShow', 'OrderCtrl', ['worker']);
Utils::addRoute('detailOrder', 'OrderCtrl', ['worker']);
Utils::addRoute('acceptOrder', 'OrderCtrl', ['worker']);
Utils::addRoute('libraryShow', 'LibraryCtrl', ['user']);
Utils::addRoute('userList', 'UserListCtrl', ['admin']);
Utils::addRoute('userListTable', 'UserListCtrl', ['admin']);
Utils::addRoute('userEdit', 'UserEditCtrl', ['admin']);
Utils::addRoute('userDelete', 'UserEditCtrl', ['admin']);
Utils::addRoute('userSave', 'UserEditCtrl', ['admin']);
Utils::addRoute('userNew', 'UserEditCtrl', ['admin']);

//Utils::addRoute('action_name', 'controller_class_name');