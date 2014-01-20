<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');


require(APPPATH.'libraries/REST_Controller.php');
require_once(APPPATH.'includes/kl_messages.inc');
require_once(APPPATH.'includes/test_data.inc');



/** ******************************************************************
 * Class 'Works'
 * 
 * @author      David Rolli, Bottmingen, Switzerland
 * @copyright   RBrains 2014
 * @version     1.0
 * 
 * @category    Clique
 * @package     Ausbildung
 * 
 */ 

class Works extends REST_Controller {

  function __construct()
  {
    parent::__construct();

    $this->config->load('config_ausbildung');

//    $this->load->helper( array('MY_response_helper') );
    $this->load->helper( array('MY_object2array_helper', 'MY_array2object_helper') );
  }



 /** ******************************************************************
  * Function 'index'
  * 
  * Note ...
  * 
  */    
	public function index()
	{
		echo ('Hello vom "Works" controller !');
	}



 /** ******************************************************************
  * Function 'werke_get'
  * 
  * REST access GET: get all 'Dokumente' or a defined number.<BR><BR>
  * 'num' : number of records to fetch<BR>
  * 'start' : index of first record to start with<BR>
  * 'format': outputformat, either 'json' or 'xml', default='json'; as URL parameter
  * 
  * @param  integer  $num      Via HTTP GET !  Number of records to read: default = 10
  * @param  integer  $start    Via HTTP GET !  Index of first record to read
  * @param  string   $format   As URL parameter! Outputformat ('json' or 'xml'; default = 'json')
  *   
  */    
  public function werke_get()
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
    //echo ('[Works->werke_get: $num=' . $num . ', $start=' . $start);
    $this->firephp->log($num, '[Works->werke_get: $num: ');
    $this->firephp->log($start, '[Works->werke_get: $start: ');

    // Get data from the database
    //    
    try
    {    
      $this->load->model('Werk_model');
      $result = $this->Werk_model->get_all_werke($num, $start);
  
      // Debug
      $this->firephp->log($result, '[Works->werke_get: $result: ');
  
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



 /** ******************************************************************
  * Function 'werk_get'
  * 
  * REST access GET: get a specific 'Dokumente' defined by an id.<BR><BR>
  * 'id':     id of the record to fetch; part of the URL<BR>
  * 'format': outputformat, either 'json' or 'xml', default='json'; as URL parameter
  * 
  * @param  integer  $id       Via HTTP GET !  Index (primary key) of record to read
  * @param  string   $format   As URL parameter! Outputformat ('json' or 'xml'; default = 'json')
  *
  */
  function werk_get()
  {
    global $kl_messages;
    global $http_messages;    
            
    $id = $this->get('id');

    // Debug
    $this->firephp->log($id, '[Works->werk_get: $id: ');
    $this->firephp->log($id, '[Works->werk_get: $id: ');
//    echo ("URL: '" . $this->uri->uri_string() . "'\n\n");
            
    if( ($id != 0 && !$id) || !is_numeric($id) )
    {
      $this->send_response(NULL, 4, 400);
    }

    // Get data from the database
    //
    try
    {    
      $this->load->model('Werk_model');
      $result = $this->Werk_model->get_werk($id);
  
      // Debug
      $this->firephp->log($result, '[Works->werk_get: $result: ');
  
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



 /** ******************************************************************
  * Function 'werk_post'
  * 
  * REST access POST: create a new 'Dokument'.<BR><BR>
  * 'data': n key-value pairs; as URL parameters
  * 
  * @param  string  $data     Via HTTP POST !  n key-value pairs
  * 
  */    
  function werk_post()
  {
    global $kl_messages;
    global $http_messages;    
    global $testdata;    
        
    // Debug
    echo ('[Works->werk_post: started...');
    $this->firephp->log('[Works->werk_post:  started...');

    $data = $this->get('data');

    // Debug
    $data = $testdata['werk'];
        
    // Debug
    $this->firephp->log($data, '[Works->werk_post: $data: ');
            
    if(!$data)
    {
      $this->send_response(NULL, 4, 400);
    }

    // Write new data to the database
    //
    try
    {    
      $this->load->model('Werk_model');
      $success = $this->Werk_model->create_werk($data);

      // Debug
      $this->firephp->log($success, '[Works->werk_post: $success: ');
  
      if($success)
      {
        $this->send_response($success, 0, 200);           // 200 being the HTTP response code
      }
      else
      {
        $this->send_response(NULL, 7, 404);
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
    
    // Debug
    echo ('[Works->werk_post: ...finished.');
    $this->firephp->log('[Works->werk_post: ...finished.');
  }


  
 /** ******************************************************************
  * Function 'werk_put'
  *
  * REST access PUT: update a specific 'Dokumente' defined by an id with new data.<BR><BR>
  * 'id': id of the record to update; part of the URL<BR>
  * 'data': n key-value pairs; as URL parameters
  * 
  * @param  integer  $id       Via HTTP PUT !  Index (primary key) of record to update.
  * @param  string   $data     Via HTTP PUT !  n key-value-pairs
  * 
  */    
  function werk_put()
  {
    global $kl_messages;
    global $http_messages;    
    global $testdata;    
            
    // Debug
    echo ('[Works->werk_put: started...');
    $this->firephp->log('[Works->werk_put:  started...');
            
    $id = $this->get('id');

    // Debug
    $this->firephp->log($id, '[Works->werk_put: $id: ');
//    echo ("URL: '" . $this->uri->uri_string() . "'\n\n");
            
    if( ($id != 0 && !$id) || !is_numeric($id) )
    {
      $this->send_response(NULL, 4, 400);
    }

    $data = $this->get('data');

    // Debug !!!
    $data = $testdata['werk'];
    // Debug
    $this->firephp->log($data, '[Works->werk_put: $data: ');
            
    if(!$data)
    {
      $this->send_response(NULL, 4, 400);
    }

    // Write modified data to an existing record with id=X in the database
    //
    try
    {    
      $this->load->model('Werk_model');
      $success = $this->Werk_model->update_werk($id, $data);

      // Debug
      $this->firephp->log($success, '[Works->werk_put: $success: ');
  
      if($success)
      {
        $this->send_response($success, 0, 200);           // 200 being the HTTP response code
      }
      else
      {
        $this->send_response(NULL, 8, 404);
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
    
    // Debug
    echo ('[Works->werk_put: ...finished.');
    $this->firephp->log('[Works->werk_put: ...finished.');
  }



 /** ******************************************************************
  * Function 'werk_delete'
  *
  * REST access DELETE: delete a specific 'Dokument' defined by an id.<BR><BR>
  * 'id': id of the record to delete; part of the URL<BR> 
  * DELETE a specific document.
  * 
  * @param  integer  $id       Via HTTP DELETE !  Index (primary key) of record to delete.
  * 
  */    
  function werk_delete()
  {
    global $kl_messages;
    global $http_messages;    
    global $testdata;       
        
    // Debug
    echo ('[Works->werk_delete: started...');
    $this->firephp->log('[Works->werk_delete:  started...');
            
    $id = $this->get('id');

    // Debug
    $this->firephp->log($id, '[Works->werk_delete: $id: ');
            
    if( ($id != 0 && !$id) || !is_numeric($id) )
    {
      $this->send_response(NULL, 4, 400);
    }

    // Delete data of an existing record with id=X in the database
    //
    try
    {    
      $this->load->model('Werk_model');
      $success = $this->Werk_model->delete_werk($id);

      // Debug
      $this->firephp->log($success, '[Works->werk_delete: $success: ');
  
      if($success)
      {
        $this->send_response($success, 0, 200);           // 200 being the HTTP response code
      }
      else
      {
        $this->send_response(NULL, 9, 404);
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
    
    // Debug
    echo ('[Works->werk_delete: ...finished.');
    $this->firephp->log('[Works->werk_delete: ...finished.');
  }
    


 /** ******************************************************************
  * Function 'send_response'
  * 
  * Note ...
  * 
  * @param  string   $data                data to output
  * @param  integer  $status_code   
  * @param  integer  $http_status_code   
  * @param  text     $format              output format 'json' or 'xml', default 'json'
  * @param  boolean  $rawoutput           if TRUE $data will be sent as is without any metadata; default FALSE
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

/* End of file works.php */
/* Location: ./application/controllers/works.php */