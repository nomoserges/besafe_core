<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users_model extends CI_Model {

    protected static $usersTable = 'users';
    protected static $usersPhonesTable = 'cust_phones';
    protected static $usersEmailsTable = 'cust_emails';

    private function generateUserID(){
        # $newUserID = random_string('numeric', 12).'-'.random_string('alnum', 32);
        # We keep the line above for important count of users.
        $newUserID = random_string('alnum', 32);
        $isFind = true;
        while ($isFind) {
            # Search the generate's ID in the table
            $sql = "SELECT userid FROM ".self::$usersTable." WHERE userid = ? LIMIT 1";
            $query = $this->db->query( $sql, $newUserID );
            # Check isFind
            if( $query->num_rows() > 0 ) {
                # code exist
                $isFind = true;
            }else {
                # this code do not exist
                $isFind = false;
                break;
            }
        }
        return $newUserID;
    }

    /** Registering
     * @param $data from controller
     * @return array|bool
     */
    public function register($data) {
        $userID = $this->generateUserID();
        //$qrcode = $this->prolib::qrGenerate( $userID );
        $arr = array('userid' => $userID);
        $data = array_merge($data, $arr);
        if( $this->db->insert(self::$usersTable, $data) ){
            unset($data['password']);
            /*  we will check if the phone number or email is provided. */
            # we call methods of each model
            return $userID;
        } else {
            # we put this $this->db->error(); on log
            return false;
        }
    }
    
    /** Look credentials for user (login)
     * @param $credential(userid, phone_number, email or pseudo)
     * @param $withPassword: true or false
     * @param $password
     * @return mixed
     */
    public function findWithCredentials(string $credential, $withPassword = FALSE, string $password){
        # si la recherche se fait avec le mot de passe.
        $addPasswordCheck = ' ';
        if ($withPassword == TRUE) {
            $addPasswordCheck = " AND password = '".sha1($password)."' ";
        }
        # we will set columns to avoid password and others
        $sql = "SELECT u.* "
            ."FROM " . self::$usersTable . " u"
            ." JOIN " . self::$usersPhonesTable . " p on u.userid = p.userid "
            ." JOIN " . self::$usersEmailsTable . " e on u.userid = e.userid "
            ." WHERE (u.userid = '" . $credential . "' OR pseudo='" . $credential . "' OR e.email='" . $credential
            ."' OR p.phone_number='" . $credential . "')" . $addPasswordCheck . "AND is_activated=1 LIMIT 1 ";
        $query = $this->db->query($sql);
        if ( false == $query ) {
            return false;
        } else {
            return $query->row_array();
        }
    }
    /*
    *   This section will be use to update user profile per bloc
    *   Commons : Firstname, Lastname, DOB and gender.
    *   Work : Job_title and job_description.
    *   Location: country, town and place.
    */
    public function updateCommons($data){
        $updateQuery = "UPDATE ".self::$usersTable
            ." SET username = '".$data['username'].
            "', firstname = '".$data['firstname'].
            "', lastname = '".$data['lastname'].
            "', birth_date = '".$data['birth_date'].
            "', gender = '".$data['gender'].
            "', email = '".$data['email'].
            "', id_card = '".$data['id_card'].
            "', address = '".$data['address'].
            "' WHERE userid = '".$data['userid']."' AND is_activated=1 LIMIT 1 ";
        $wxc =$this->db->query($updateQuery);
        if ( false === $wxc ) {
            return $wxc;
        } else {
            $dataX = $this->findWithCredentials($data['userid'], false, '');
            $this->_userQrCode($dataX);
            return $dataX;
        }
    }

}