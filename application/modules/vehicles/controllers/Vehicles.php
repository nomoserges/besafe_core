<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vehicles extends MX_Controller {

    /* Index of controller. */
    public function index() {
        echo 'Vehicles module controller';
    }

    /** Add vehicle. */
    public function addvehicle(){
        $modelData = array(
            'userid'        => $_REQUEST['userid'],
            'reference'     => $_REQUEST['v_reference'],
            'mark'          => $_REQUEST['v_mark'],
            'color'         => $_REQUEST['v_color'],
            'year'          => $_REQUEST['v_year']
        );
        $modelHandler = $this->CarsModel->insert($modelData);
        if ( $modelHandler == FALSE ) {
            # no data
            $this->prolib->jsonOutput('error', 'Vehicles', 'Registering vehicle fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Vehicles', 'Registering vehicle succeed', []);
        }
    }

    /** Get all vehicles. */
    public function getvehicles(){
        $modelHandler = $this->CarsModel->getAllVehicles();
        if ( !is_array($modelHandler) ) {
            # no data
            $this->prolib->jsonOutput('error', 'Vehicles', 'Retrieving vehicles fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Vehicles', 'Retrieving vehicles succeed', $modelHandler);
        }
    }

    /** Get vehicle's users. */
    public function getcarusers(){
        $modelHandler = $this->CarsUsersModel->getUsersVehicles($_REQUEST['credential']);
        if ( !is_array($modelHandler) ) {
            # no data
            $this->prolib->jsonOutput('error', 'Vehicles', 'Retrieving car user fail', []);
        } else {
            # we have informations
            $this->prolib->jsonOutput('success', 'Vehicles', 'Retrieving car user succeed', $modelHandler);
        }
    }
}