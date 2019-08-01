<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends MX_Controller {
    public $SECRET_KEY = 'xkby1ct#';

    /* Index of controller. */
    public function index() {
        
        echo 'User module controller<br/>';
        echo sha1('mvilongo') . '<br/>';
    }

    /** User registration */
    public function register(){
        $this->prolib::jsonInput();
        $credential = [];
        # we check if the pseudo is an email or phone number
        if( false === $this->prolib->checkEmail($_REQUEST['u_pseudo']) ){
            $cx = $this->prolib->sanitizePhoneNumber($_REQUEST['u_pseudo']);
            $credential = ( 'invalid' !== $cx ) ? array('phone', $cx) : array('invalid', 'invalid');
        } else {    $credential = array('email', $_REQUEST['u_pseudo']);  }
        # phone or email is ok
        if( $credential[0] !== 'invalid' ){
            # we check password
            $modelData = array(
                'firstname'     => $_REQUEST['u_firstname'],
                'lastname'      => $_REQUEST['u_lastname'],
                'pseudo'        => $_REQUEST['u_pseudo'],
                'password'      => sha1($_REQUEST['u_password'])
            );
            $modelHandler = $this->UsersModel->register($modelData);
            
            if ( $modelHandler == FALSE ) {
                # no data
                $this->prolib->jsonOutput('error', 'User', 'Registering user fail', []);
            } else if( $modelHandler == 'already' ) {
                $this->prolib->jsonOutput('error', 'User', 'User already resgistered', []);
            } else {
                # we have informations
                $this->prolib->jsonOutput('success', 'User', 'Registering user succeed', 
                array(
                    'userid'=>$modelHandler, 
                    'access_token' => $this->SECRET_KEY . $modelHandler, 
                    'expires_in' => 24 * 60 * 60)
                );
            }
        } else {
            $this->prolib->jsonOutput('error', 'User', 'Invalid data', []);
        }
    }

    /** User Login. */
    public function login() {
        $this->prolib::jsonInput();
        # credential, password
        $modelHandler = $this->UsersModel->findWithCredentials($_REQUEST['u_pseudo'], true, $_REQUEST['u_password']);
        if( false === $modelHandler ) {
            $this->prolib->jsonOutput('error', 'Login', 'Error occured', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'User', 'Login user succeed', 
            array(
                'userid' => $modelHandler[0]['userid'], 
                'access_token' => $this->SECRET_KEY . $modelHandler[0]['userid'], 
                'expires_in' => 24 * 60 * 60)
            );
        }
    }
}