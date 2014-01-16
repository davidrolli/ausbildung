<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


/** ******************************************************************
* Function 'prep_response'
* 
* Note ...
* 
* @param integer  $data           data to output
* @param text     $status_code   
* @param text     $status_txt    
* @param text     $format         output format 'json' or 'xml', default 'json'
* 
* @return mixed   $out_data       array with all output (data & metadata)
* 
*/    
function prep_response($data = NULL,
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

  return ($out_data);
}

/* End of 'MY_response_helper.php' */
/* Location: ./application/helpers/ */