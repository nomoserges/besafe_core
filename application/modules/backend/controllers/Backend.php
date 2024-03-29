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

    /***************************************************************
    *                       CUSTOMERS SECTION
    *************************************************************** */

    /* Insert new customer handly. */
    public function newcostumer(){
        $modelData = array(
            'firstname'     => $_REQUEST['u_firstname'],
            'lastname'      => $_REQUEST['u_lastname'],
            'gender'        => $_REQUEST['u_gender'],
            'country'       => $_REQUEST['u_country'],
            'town'          => $_REQUEST['u_town'],
            'place'         => $_REQUEST['u_place'],
            'dob'           => $_REQUEST['u_dob'],
            'job_title'     => $_REQUEST['u_job_title'],
        );
        $modelHandler = $this->UsersModel->register($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Customer', 'Registering customer fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Customer', 'Registering customer succeed', []);
        }
    }

    /* Get customers list. */
    public function getcostumers(){
        $modelHandler = $this->UsersModel->getAllCustomers();
        echo json_encode($modelHandler);
    }

    public function getcustomersfullname(){
        $retVal = $_REQUEST['filter'] ;
        $modelHandler = $this->UsersModel->getCustomersFullname($retVal);
        echo json_encode($modelHandler);
    }

    /** Add customer identication. */
    public function addidentication() {
        $modelData = array(
            'userid'        => $_REQUEST['userid'],
            'doc_type'      => $_REQUEST['u_identication_type'],
            'doc_number'    => $_REQUEST['u_identication_number'],
            'start_date'    => $_REQUEST['u_identication_start'],
            'end_date'      => $_REQUEST['u_identication_end']
        );
        $modelHandler = $this->IdenticationsModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Identication', 'Registering identication fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Identication', 'Registering identication succeed', []);
        }
    }

    /* Get customer's identication. */
    public function getidentication(){
        $modelHandler = $this->IdenticationsModel->getAllIdentications();
        echo json_encode($modelHandler);
    }

    /** Add customer phones numbers. */
    public function addphone() {
        $modelData = array(
            'userid'            => $_REQUEST['userid'],
            'phone_number'      => $_REQUEST['u_phone_number']
        );
        $modelHandler = $this->PhonesModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Phones', 'Registering phone fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Phones', 'Registering phone succeed', []);
        }
    }

    /* Get customer's phones. */
    public function getphones(){
        $modelHandler = $this->PhonesModel->getAllPhones();
        echo json_encode($modelHandler);
    }

    /** Add customer email. */
    public function addemail() {
        $modelData = array(
            'userid'     => $_REQUEST['userid'],
            'email'      => $_REQUEST['u_email']
        );
        $modelHandler = $this->EmailsModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Emails', 'Registering email fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Emails', 'Registering email succeed', []);
        }
    }

    /* Get emails. */
    public function getemails(){
        $modelHandler = $this->EmailsModel->getAllEmails();
        echo json_encode($modelHandler);
    }
    
    /***************************************************************
    *                       VEHICLES SECTION
    *************************************************************** */
    public function getallvehicles(){
        $modelHandler = $this->CarsModel->getAllVehicles();
        echo json_encode($modelHandler);
    }

    /** Insert new vehicle. */
    public function newvehicle(){
        $modelData = array(
            'reference'     => $_REQUEST['v_reference'],
            'mark'      => $_REQUEST['v_mark'],
            'year'     => $_REQUEST['v_year'],
            'color'      => $_REQUEST['v_color']
        );
        $modelHandler = $this->CarsModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Vehicle', 'Registering vehicle fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Vehicle', 'Registering vehicle succeed', []);
        }
    }

    /** New car user */
    public function newcaruser(){
        $modelData = array(
            'userid'            => $_REQUEST['userid'],
            'reference'         => $_REQUEST['v_reference'],
            'type_relation'     => $_REQUEST['v_type_relation'],
            'type_owner'        => $_REQUEST['v_type_owner'],
            'num_driver'        => $_REQUEST['v_num_driver'],
            'start_date'        => $_REQUEST['v_start_date']
        );
        $modelHandler = $this->CarsUsersModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'User Vehicle', 'Registering user vehicle fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'User Vehicle', 'Registering user vehicle succeed', []);
        }
    }

    /** All user's vehicles */
    public function getallusersvehicles(){
        $modelHandler = $this->CarsUsersModel->getAllUsersVehicles();
        echo json_encode($modelHandler);
    }
}