<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MX_Controller {

    /* Index of controller. */
    public function index() {
        
        echo 'User module controller<br/>';
        echo sha1('mvilongo') . '<br/>';
    }
}