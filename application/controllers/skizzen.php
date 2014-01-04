<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Skizzen extends CI_Controller {

  function __construct()
  {
    parent::__construct();
    require(APPPATH.'libraries/REST_Controller.php');
  }


	public function index()
	{
		echo ('Hello vom "Skizzen" controller !');
	}


  public function skizzen_get()
  {
    echo ('[Skizzen->get_skizzen: ...');
  }


  public function check($num=20, $start=0 )
  {
    echo ('[Skizzen->check: $num=' . $num . ', $start=' . $start);
  }

}

/* End of file skizzen.php */
/* Location: ./application/controllers/skizzen.php */