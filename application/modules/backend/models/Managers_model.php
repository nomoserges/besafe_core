<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Managers_model extends CI_Model {

    protected static $managersTable = 'users_managers';

    
    /** Look credentials for user (login)
     * @param $credential(userid, phone_number, email or pseudo)
     * @param $withPassword: true or false
     * @param $password
     * @return mixed
     */
    public function findWithCredentials($credential, $withPassword, $password){
        # si la recherche se fait avec le mot de passe.
        $addPasswordCheck = ' ';
        if ($withPassword == true) {
            $addPasswordCheck = " AND password = '".sha1($password)."' ";
        }
        # we will set columns to avoid password and others
        $sql = "SELECT * "
            ."FROM ".self::$managersTable
            ." WHERE (userid = '".$credential."' OR username='".$credential."' OR email='".$credential
            ."' OR phone_number='".$credential."')".$addPasswordCheck."AND is_activated=1 LIMIT 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return $query;
        } else {
            return $query->row_array();
        }
    }
    

}