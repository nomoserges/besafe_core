<?php

defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Description of site
 *
 * @author https://www.roytuts.com
 */
class Users extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {
        $var = array(
            'msgType'   => 'success', 
            'msgTitle'  => 'a title', 
            'msgText'   => 'success',
            'msgData'   => array('name' => 'mvilongo', 'surname' => 'serge')
        );
        echo json_encode($var);
    }

}
