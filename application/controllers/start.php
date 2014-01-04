<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Start extends CI_Controller {

  function __construct()
  {
    parent::__construct();
    require(APPPATH.'libraries/REST_Controller.php');
  }


	public function index()
	{
		echo ('Hello vom start controller !');
    $this->firephp->log("FirePHP is working!");
	}


  public function check($blabla='No Comment to display entered ?!')
  {
    echo $blabla;
  }

}

/* End of file start.php */
/* Location: ./application/controllers/start.php */