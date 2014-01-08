<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


require(APPPATH.'libraries/REST_Controller.php');
require_once(APPPATH.'includes/kl_messages.inc');



class Docs extends REST_Controller {

  function __construct()
  {
    parent::__construct();
    //echo ("notizen_url = '" . $this->config->item('notizen_url') . "'\n");

    $this->load->helper( array('MY_object2array_helper', 'MY_array2object_helper') );
  }


 /**
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
		echo ('Hello vom "Docs" controller !');
	}


 /**
  * Function 'check'
  * 
  * Test function to check paramter passing via URL
  * 
  * @param  integer $num      Number of records to read: default = 10
  * @param  integer $start    Index of first reacord to read
  * 
  */
  public function check($num=10, $start=0)
  {
    // Debug
    //echo ('[Docs->check: $num=' . $num . ', $start=' . $start);
    $this->firephp->log($num, '[Docs->check: $num: ');
    $this->firephp->log($start, '[Docs->check: $start: ');
    
  }


 /**
  * Function 'dokumente_get'
  * 
  * REST access GET: get all 'Dokumente' or a defined number.<BR><BR>
  * 'num' : number of records to fetch<BR>
  * 'start' : index of first record to start with<BR>
  * 'format': outputformat, either 'json' or 'xml', default='json'; as URL parameter
  * 
  * @param  integer $num      Via HTTP GET! Number of records to read: default = 10
  * @param  integer $start    Via HTTP GET! Index of first reacord to read
  * @param  string  $format   As URL paameter! Outputformat
  *   
  */    
  public function dokumente_get()
  {
    global $kl_messages;
    global $http_messages;    
            
    $n = 10;      // Only during testing !!!
    $s = 0;
    
    if(!$this->get('num') || $this->get('num') <= 0)
    {
      $num = $n;
    }
    else {
      $num = $this->get('num');
    }

    if(!$this->get('start') || $this->get('start') <= 0)
    {
      $start = $s;
    }
    else {
      $start = $this->get('start');
    }

    // Debug
    //echo ('[Docs->dokumente_get: $num=' . $num . ', $start=' . $start);
    $this->firephp->log($num, '[Docs->dokumente_get: $num: ');
    $this->firephp->log($start, '[Docs->dokumente_get: $start: ');

    // Get data from the database
    //    
    try
    {    
      $this->load->model('Dokument_model');
      $result = $this->Dokument_model->get_all_dokumente($num, $start);
  
      // Debug
      $this->firephp->log($result, '[Docs->dokumente_get: $result: ');
  
      if($result)
      {
        $this->send_response($result, 0, 200);           // 200 being the HTTP response code
      }
      else
      {
        $this->send_response(NULL, 3, 404);
      }
    }
    catch (Exception $e) 
    {
      $this->send_response(NULL, 3, 404);
    }
    
  }


 /**
  * Function 'dokumente_get'
  * 
  * REST access GET: get all 'Dokumente' or a defined number.<BR><BR>
  * 'num':    number of records to fetch; part of the URL<BR>
  * 'start':  index of first record to start with; part of the URL<BR>
  * 'format': outputformat, either 'json' or 'xml', default='json'; as URL parameter
  * 
  * @param  integer $num      Via HTTP GET! Number of records to read: default = 10
  * @param  integer $start    Via HTTP GET! Index of first record to read
  * @param  string  $format   As URL paameter! Outputformat
  *
  */
  function dokument_get()
  {
    global $kl_messages;
    global $http_messages;    
            
    $id = $this->get('id');

    // Debug
    $this->firephp->log($id, '[Docs->dokument_get: $id: ');
        
    if( ($id != 0 && !$id) || !is_numeric($id) )
    {
      $this->send_response(NULL, 4, 400);
    }

    // Get data from the database
    //
    try
    {    
      $this->load->model('Dokument_model');
      $result = $this->Dokument_model->get_dokument($id);
  
      // Debug
      $this->firephp->log($result, '[Docs->dokument_get: $result: ');
  
      if($result)
      {
        $this->send_response($result, 0, 200);           // 200 being the HTTP response code
      }
      else
      {
        $this->send_response(NULL, 3, 404);
      }
    }
    catch (Exception $e) 
    {
      $c = $e->getCode();
      
      switch ($c) {
        case '3':
          $this->send_response(NULL, 3, 404);
          break;

        case '4':
          $this->send_response(NULL, 4, 400);
          break;
        
        default:
          $this->send_response(NULL, 4, 400);
          break;
      }
    }
  }


 /**
  * Function 'dokument_post'
  * 
  * Note ...
  * 
  * @param integer $data          data to output
  * @param text    $status_code   
  * @param text    $status_txt    
  * @param text    $format        output format 'json' or 'xml', default 'json'
  * 
  */    
  function dokument_post()
  {
    //$this->some_model->updateDokument( $this->get('id') );
    $message = array('id' => $this->get('id'), 'cd' => $this->post('cd'), 'titel' => $this->post('titel'), 'message' => 'ADDED!');
    
    $this->response($message, 200);                   // 200 being the HTTP response code
  }

  
 /**
  * Function 'dokument_delete'
  * 
  * Note ...
  * 
  * @param integer $data          data to output
  * @param text    $status_code   
  * @param text    $status_txt    
  * @param text    $format        output format 'json' or 'xml', default 'json'
  * 
  */    
  function dokument_delete()
  {
    //$this->some_model->deleteDokument( $this->get('id') );
      $message = array('id' => $this->get('id'), 'message' => 'DELETED!');
      
      $this->response($message, 200);                   // 200 being the HTTP response code
  }
    

 /**
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

/* End of file docs.php */
/* Location: ./application/controllers/docs.php */