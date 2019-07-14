<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Emails_model extends CI_Model {
    
    protected static $emailTable = 'cust_emails';
    protected static $usersTable = 'users';

    /** Insert new phone. */
    public function insert (array $data)  {
        if( $this->db->insert(self::$emailTable, $data) ){
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

    /** Emails for specific user. */
    public function getUserEmails(sring $userID, string $email = null) {
        $sql = "SELECT * "
            ."FROM ".self::$emailTable
            ." WHERE (userid = '" . $userID . "' OR email = '" . $email . "') AND status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Emails . */
    public function getAllEmails() {
        $sql = "SELECT e.id, u.userid, u.pseudo, u.firstname, u.lastname, e.email "
            ."FROM " . self::$emailTable . " e "
            ."JOIN " . self::$usersTable . " u on e.userid = u.userid "
            ." WHERE status = 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->result_array();
        }
    }

    /** Soft delete of row. */
    public function delete(sring $userID, string $email) {
        $updateQuery = "UPDATE ".self::$emailTable
            ." SET status = 0 "
            ."WHERE userid = '" . $userID . "' AND doc_number='" . $email . "' LIMIT 1 ";
        if ( $this->db->query($updateQuery) ) {
            return true;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }

}
