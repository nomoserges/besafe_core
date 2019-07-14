<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Phones_model extends CI_Model {
    
    protected static $phonesTable = 'cust_phones';
    protected static $usersTable = 'users';

    /** Insert new phone. */
    public function insert (array $data)  {
        if( $this->db->insert(self::$phonesTable, $data) ){
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

    /** Phones for specific user. */
    public function getUserPhones($userID, $phone=null) {
        $sql = "SELECT * "
            ."FROM ".self::$phonesTable
            ." WHERE (userid = '" . $userID . "' OR phone_number = '" . $phone . "') AND status = 1 ";
            echo $sql;
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Phones. */
    public function getAllPhones() {
        $sql = "SELECT p.id, u.userid, u.pseudo, u.firstname, u.lastname, p.phone_number "
            ."FROM " . self::$phonesTable . " p "
            ."JOIN " . self::$usersTable . " u on p.userid = u.userid "
            ." WHERE status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Soft delete of row. */
    public function delete(sring $userID, string $phone) {
        $updateQuery = "UPDATE ".self::$phonesTable
            ." SET status = 0 "
            ."WHERE userid = '" . $userID . "' AND phone_number='" . $phone . "' LIMIT 1 ";
        if ( $this->db->query($updateQuery) ) {
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

}
