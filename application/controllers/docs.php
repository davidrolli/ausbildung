<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

require(APPPATH.'libraries/REST_Controller.php');

$skizzen = array(
  array ('cd' => 11, 'titel' => 'Skizze 1'),
  array ('cd' => 12, 'titel' => 'Skizze 2'),
  array ('cd' => 13, 'titel' => 'Skizze 3'),
  array ('cd' => 14, 'titel' => 'Skizze 4'),
  array ('cd' => 15, 'titel' => 'Skizze 5')); 


class Docs extends REST_Controller {

  function __construct()
  {
    parent::__construct();
  }


	public function index()
	{
		echo ('Hello vom "Docs" controller !');
	}


  public function check($num=20, $start=0 )
  {
    echo ('[Docs->check: $num=' . $num . ', $start=' . $start);
  }


  public function skizzen_get()
  {
    global $skizzen;
    
    if($skizzen)
    {
      $this->response($skizzen, 200);           // 200 being the HTTP response code
    }

    else
    {
      $this->response(array('error' => 'Konnte keine Skzzen finden!'), 404);
    }
  }


  function skizze_get()
  {
    global $skizzen;

    if($this->get('id') != 0 && !$this->get('id') )
    {
      $this->response(NULL, 400);
    }

    $skizze = @$skizzen[$this->get('id')];

    if($skizze)
    {
        $this->response($skizze, 200);                  // 200 being the HTTP response code
    }
    else
    {
        $this->response(array('error' => 'Konnte die Skizze mit der Id=' . $this->get('id') . ' nicht finden!'), 404);
    }
  }


  function skizze_post()
  {
    //$this->some_model->updateSkizze( $this->get('id') );
    $message = array('id' => $this->get('id'), 'cd' => $this->post('cd'), 'titel' => $this->post('titel'), 'message' => 'ADDED!');
    
    $this->response($message, 200);                   // 200 being the HTTP response code
  }

  
  function skizze_delete()
  {
    //$this->some_model->deleteSkizze( $this->get('id') );
      $message = array('id' => $this->get('id'), 'message' => 'DELETED!');
      
      $this->response($message, 200);                   // 200 being the HTTP response code
  }
    
}

/* End of file docs.php */
/* Location: ./application/controllers/docs.php */