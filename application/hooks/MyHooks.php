<?php   defined('BASEPATH') OR exit('No direct script access allowed');

class Myhooks {
    
    /*  Enable cors on core app. */
    public function enableCors() {
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
        $method = $_SERVER['REQUEST_METHOD'];
        if($method == "OPTIONS") { die(); }
    }
}

