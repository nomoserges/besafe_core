<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Identications_model extends CI_Model {
    
    protected static $identicationTable = 'cust_identications';
    protected static $usersTable = 'users';

    /** Insert new phone. */
    public function insert (array $data)  {
        if( $this->db->insert(self::$identicationTable, $data) ){
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

    /** Identication for specific user. */
    public function getUserIdentications(sring $userID, string $docNumber = null) {
        $sql = "SELECT * "
            ."FROM ".self::$identicationTable
            ." WHERE (userid = '" . $userID . "' OR doc_number = '" . $docNumber . "') AND status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Identications. */
    public function getAllIdentications() {
        $sql = "SELECT * "
            ."FROM ".self::$identicationTable
            ." WHERE status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Soft delete of row. */
    public function delete(sring $userID, string $docNumber) {
        $updateQuery = "UPDATE ".self::$identicationTable
            ." SET status = 0 "
            ."WHERE userid = '" . $userID . "' AND doc_number='" . $docNumber . "' LIMIT 1 ";
        if ( $this->db->query($updateQuery) ) {
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

}
