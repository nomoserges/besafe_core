<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Prolib {

    protected $CI;

    public function __construct() {
        $this->CI =& get_instance();
    }

    
    /**
     * Get RAW-JSON data from client-side forms.
     */
    public function jsonInput(){
        $_REQUEST = json_decode(trim(file_get_contents('php://input')), true);
    }

    /** Output data in Json format.
     * @param string $msgType
     * @param $msgTitle
     * @param $msgBody
     * @param array $msgData
     */
    public function jsonOutput(string $msgType, string $msgTitle, string $msgText, array $msgData){
        echo json_encode(
            array(
                'msgType' => $msgType,
                'msgTitle' => $msgTitle,
                'msgText' => $msgText,
                'msgData' => $msgData,
            )
        );
    }

}