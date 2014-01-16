<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


require_once(APPPATH.'includes/kl_messages.inc');


class Dbdir extends CI_Controller {


  function __construct()
  {
    parent::__construct();

  }



 /** ******************************************************************
  * Function 'index'
  * 
  * Note ...
  * 
  * @param integer $data          data to output
  * @param text    $status_code   
  * @param text    $status_txt    
  * @param text    $format        output format 'json' or 'xml', default 'json'
  * 
  */    
  public function index()
  {
    echo ('Hello vom "Dbdir" controller !');
  }



 /** ******************************************************************
  * Function 'query'
  * 
  * Test function to check paramter passing via URL
  * 
  * @param  string  $sqlstr     SQL string to query database directly.
  *                              Only read access ist allowed !
  * 
  */
  public function query($sqlstr)
  {
    // Debug
    //echo ('[Docs->query: $num=' . $num . ', $start=' . $start);
    $this->firephp->log($sqlstr, '[Dbdir->query: $sqlstr: ');
    
  }



 /** ******************************************************************
  * Function 'prep_response'
  * 
  * Note ...
  * 
  * @param integer $data       data to output
  * @param text $status_code   
  * @param text $status_txt    
  * @param text $format        output format 'json' or 'xml', default 'json'
  * 
  */    
  function send_response($data = NULL,
                         $status_code = 998,
                         $http_status_code = 999,
                         $format = 'json',
                         $rawoutput = FALSE)
  {
    global $kl_messages;
    global $http_messages;    

    // Debug
/*
    $this->firephp->log($data, '[prep_response: $data: ');
    $this->firephp->log($status_code, '[prep_response: $status_code: ');
    $this->firephp->log($kl_messages[$status_code], '[prep_response: $kl_messages[$status_code]: ');
    $this->firephp->log($http_status_code, '[prep_response: $http_status_code: ');
    $this->firephp->log($http_messages[$http_status_code], '[prep_response: $http_messages[$http_status_code]: ');
    $this->firephp->log($format, '[prep_response: $format: ');
*/
    if ($rawoutput == FALSE)
    {
      $out_data['data'] = $data;

      if ($status_code != 0)
      {
        $s = FALSE;
      }
      else
      {
        $s = TRUE;
      }

      $out_data['meta'][] = array('success' => $s,
                                  'resp_code' => $status_code,
                                  'resp_msg' =>  $kl_messages[$status_code],
                                  'http_code' => $http_status_code,
                                  'http_msg' =>  $http_messages[$http_status_code]
                                 );

      // Debug
//      $this->firephp->log($out_data['data'], '[prep_response: $out_data[\'data\']: ');
    }
    else
    {
      $out_data = $data;
    }

    if ($http_status_code >= 200 && $http_status_code < 300)
    {
      $status_header_code = 200;
    }
    else
    {
      $status_header_code = 417;
    }

    try
    {
      $this->response($out_data, $http_status_code);

    }
    catch (Exception $e)
    {
        echo $e->getMessage();
    }
  }

}

/* End of file dbdir.php */
/* Location: ./application/controllers/dbdir.php */