<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Managers_model extends CI_Model {

    protected static $managersTable = 'users_managers';
    protected static $usersTable = 'users';
    
    /** Look credentials for user (login)
     * @param $credential(userid, phone_number, email or pseudo)
     * @param $withPassword: true or false
     * @param $password
     * @return mixed
     */
    public function findManager($credential, $withPassword, $password){
        # si la recherche se fait avec le mot de passe.
        $addPasswordCheck = ' ';
        if ($withPassword == true) {
            $addPasswordCheck = " AND user_password = '".sha1($password)."' ";
        }
        # we will set columns to avoid password and others
        $sql = "SELECT m.userid, m.user_login, m.created_at, m.last_login, u.firstname, u.lastname "
            ."FROM ".self::$managersTable . " m"
            ." JOIN " . self::$usersTable . " u on m.userid = u.userid "
            ." WHERE (m.userid = '".$credential."' OR m.user_login='".$credential."') "
            . $addPasswordCheck . "AND status = 1 LIMIT 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->row_array();
        }
    }
    

}