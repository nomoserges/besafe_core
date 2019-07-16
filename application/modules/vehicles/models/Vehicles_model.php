<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Vehicles_model extends CI_Model {

    protected static $vehiclesTable = 'vehicles';


    /** Registering
     * @param $data from controller
     * @return array|bool
     */
    public function insert($data) {
        if( $this->db->insert(self::$vehiclesTable, $data) ){
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }
    
   /** Specific vehicle. */
    public function getVehicle(sring $reference) {
        $sql = "SELECT * "
            ."FROM ".self::$vehiclesTable
            ." WHERE reference = '" . $userID . "' AND status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }
   
    /** All vehicles. */
    public function getAllVehicles() {
        $sql = "SELECT * "
            ."FROM ".self::$vehiclesTable
            ." WHERE status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Soft delete of row. */
    public function delete(sring $reference) {
        $updateQuery = "UPDATE ".self::$vehiclesTable
            ." SET status = 0 "
            ."WHERE reference = '" . $reference . "' LIMIT 1 ";
        if ( $this->db->query($updateQuery) ) {
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

}