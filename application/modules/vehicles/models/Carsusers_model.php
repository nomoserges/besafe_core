<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Carsusers_model extends CI_Model {

    protected static $carsusersTable = 'cars_users';
    protected static $usersTable = 'users';

    /** Registering
     * @param $data from controller
     * @return array|bool
     */
    public function insert($data) {
        if( $this->db->insert(self::$carsusersTable, $data) ){
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }
    
   /** Get user's vehicle. */
    public function getUsersVehicles(sring $credential) {
        $sql = "SELECT * "
            ."FROM ".self::$carsusersTable
            ." WHERE (userid = '" . $credential . "' OR reference = '" . $credential . "') AND status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->row_array();
        }
    }

    /** Get all user's vehicle. */
    public function getAllUsersVehicles() {
        $sql = "SELECT c.*, CONCAT(u.firstname, CONCAT(' ',  u.lastname)) as customer "
            ."FROM ".self::$carsusersTable ." c "
            ." JOIN " . self::$usersTable . " u on c.userid = u.userid "
            ." WHERE status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->row_array();
        }
    }

    /** Soft delete of row. */
    public function delete(sring $userID, sring $reference) {
        $updateQuery = "UPDATE ".self::$carsusersTable
            ." SET status = 0 "
            ."WHERE (userid = '" . $userID . "' AND reference = '" . $reference . "' LIMIT 1 ";
        if ( $this->db->query($updateQuery) ) {
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

}