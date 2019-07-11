<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Backend extends MX_Controller {

    /* Index of controller. */
    public function index() {
        echo 'Backend module controller';
    }

    /** Login of user manager */
    public function dologin(){
        $modelHandler = $this->ManagersModel->findManager($_REQUEST['userLogin'], TRUE, $_REQUEST['userPassword']);
        if (is_array($modelHandler)) {
            # we have informations
            $this->prolib->jsonOutput('success', 'Login', 'Login succed', $modelHandler);
        } else {
            # no data
            $this->prolib->jsonOutput('error', 'Login', 'Invalid credentials', []);
        }
    }
}