<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

class MyHooks {

    /**
     * This method will enable CORS.
     * */
    public function enableCors(){
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
        $method = $_SERVER['REQUEST_METHOD'];
        if($method == "OPTIONS") { die(); }
    }
}