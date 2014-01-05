<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

require(APPPATH.'libraries/REST_Controller.php');

$papiere = array(
  array ('cd' => 11, 'titel' => 'Dokument 1'),
  array ('cd' => 12, 'titel' => 'Dokument 2'),
  array ('cd' => 13, 'titel' => 'Dokument 3'),
  array ('cd' => 14, 'titel' => 'Dokument 4'),
  array ('cd' => 15, 'titel' => 'Dokument 5')); 


class Docs extends REST_Controller {

  function __construct()
  {
    parent::__construct();
    echo ("notizen_url = '" . $this->config->item('notizen_url') . "'\n");
  }


	public function index()
	{
		echo ('Hello vom "Docs" controller !');
	}


  public function check($num=20, $start=0 )
  {
    echo ('[Docs->check: $num=' . $num . ', $start=' . $start);
  }


  public function dokumente_get()
  {
    global $papiere;
    
    if($papiere)
    {
      $this->response($papiere, 200);           // 200 being the HTTP response code
    }

    else
    {
      $this->response(array('error' => 'Konnte keine Dokumente finden!'), 404);
    }
  }


  function dokument_get()
  {
    global $papiere;

    if($this->get('id') != 0 && !$this->get('id') )
    {
      $this->response(NULL, 400);
    }

    $result = @$papiere[$this->get('id')];

    if($result)
    {
        $this->response($result, 200);                  // 200 being the HTTP response code
    }
    else
    {
        $this->response(array('error' => 'Konnte das Dokument mit der Id=' . $this->get('id') . ' nicht finden!'), 404);
    }
  }


  function dokument_post()
  {
    //$this->some_model->updateDokument( $this->get('id') );
    $message = array('id' => $this->get('id'), 'cd' => $this->post('cd'), 'titel' => $this->post('titel'), 'message' => 'ADDED!');
    
    $this->response($message, 200);                   // 200 being the HTTP response code
  }

  
  function dokument_delete()
  {
    //$this->some_model->deleteDokument( $this->get('id') );
      $message = array('id' => $this->get('id'), 'message' => 'DELETED!');
      
      $this->response($message, 200);                   // 200 being the HTTP response code
  }
    
}

/* End of file docs.php */
/* Location: ./application/controllers/docs.php */