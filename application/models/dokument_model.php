<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Dokument_model extends CI_Model {

  function __construct()
  {
    parent::__construct();

  }


 /**
  * Function 'get_dokument'
  * 
  * Note ...
  * 
  * @param  integer $id            primary key
  * 
  */ 
  function get_dokument($id)
  {
    global $kl_messages;
    global $http_messages;    
        
    // Debug
    $this->firephp->log('Dokument_model-> get_dokument: started ... ');
    $this->firephp->log($id, 'Dokument_model-> get_dokument:  $id');

    try
    {
      $sql_str = 'SELECT * FROM clique.v_r_dokumente WHERE id=';
//      $sql_str = 'SELECT * FROM clique.v_dokumente';
      
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> get_dokument: $sql_str: ');

      if ($id && is_int((int)$id)) {
        $sql_str .= $id;
      }
      else {
        throw new Exception($kl_messages[4], 4);     // Wrong input parameter.
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> get_dokument: $sql_str: ');

      $query = $this->db->query($sql_str);
  
      $out = array();
      $out = $query->result();

      // Debug
      $this->firephp->log($out, '[Dokument_model-> get_dokument: $out: ');
      $this->firephp->log(count($out), '[Dokument_model-> get_dokument: count($out): ');
    }
    catch (Exception $e) 
    {
      throw new Exception($kl_messages[2], 2);     // No result.
    }
    
    // Debug
    $this->firephp->log($out, '[get: $out: ');
    
    return $out;
  }
  

 /**
  * Function 'get_all_dokumente'
  * 
  * Reads all or a defined number records from database. 
  * 
  * @param  integer $num      number of records to read
  * @param  integer $start    index of first reacord to read
  * @return array   $out      read records as array  
  * 
  */    
  function get_all_dokumente($num, $start)
  {
    // Debug
    $this->firephp->log('Dokument_model-> get_all_dokumente: started ... ');
    $this->firephp->log($num, 'Dokument_model-> get_all_dokumente:  $num');
    $this->firephp->log($start, 'Dokument_model-> get_all_dokumente:  $start');

    try
    {
      $sql_str = 'SELECT * FROM clique.v_r_dokumente';
//      $sql_str = 'SELECT * FROM clique.v_dokumente';

      if ($num) {
        $sql_str .= " LIMIT " . $num;
      }
      
      if ($start) {
        $sql_str .= " OFFSET " . $start;
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> get_all_dokumente: $sql_str: ');

      $query = $this->db->query($sql_str);
  
      $out = array();
//      $o = $query->result();
      $out = $query->result();
      
      // Debug
      $this->firephp->log($out, '[Dokument_model-> get_all_dokumente: $out: ');
      $this->firephp->log(count($out), '[Dokument_model-> get_all_dokumente: count($out): ');

/*
       if ($o)
      {
//        $out = object2array($o[0]);
//        $out = object2array($o);
        $out = $o;
      }
*/
    }
    catch (Exception $e) 
    {
      throw new MyException(2);
//  ($message = null, $code = 0, Exception $previous = null);
      
    }
    
    // Debug
    $this->firephp->log($out, '[get: $out: ');
    
    return $out;
  }


 /**
  * Function 'create_dokument'
  * 
  * Creates new record in database.
  * 
  * @param  array   $data           data to store = data of the new record
  * @return integer                 indicates the number of items  
  * 
  */ 
  function create_dokument($data)
  {
    echo "[Dokument_model-> create_dokument: started... ]";
    
    $this->title   = $_POST['title']; // please read the below note
    $this->content = $_POST['content'];
    $this->date    = time();

    $this->db->insert('entries', $this);
  }


 /**
  * Function 'update_dokument'
  * 
  * Updates a record with new data
  * 
  * @param  integer $id            primary key
  * @param  array   $data           data to store = data of the new record
  * @return integer Indicates the number of items  
  * 
  */ 
  function update_dokument($id, $data)
  {
    echo "[Dokument_model-> update_dokument: started... ]";

    $this->title   = $_POST['title'];
    $this->content = $_POST['content'];
    $this->date    = time();

    $this->db->update('entries', $this, array('id' => $_POST['id']));    
  }


 /**
  * Function 'get_all_dokumente'
  * 
  * Note ...
  * 
  * @param integer $data          data to output
  * @param text    $status_code   
  * @param text    $status_txt    
  * @param text    $format        output format 'json' or 'xml', default 'json'
  * @return integer Indicates the number of items  
  * 
  */ 
  function delete_dokument($id)
  {
    echo "[Dokument_model-> delete_dokument: started... ]";
    
  }
  
}



/* End of file dokument_model.php */
/* Location: ./application/model/dokument_model.php */