<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');


/** ******************************************************************
 * Class 'Dokument_model'
 * 
 * @author      David Rolli, Bottmingen, Switzerland
 * @copyright   RBrains 2014
 * @version     1.0
 * 
 * @category    Clique
 * @package     Ausbildung
 * 
 */ 

class Dokument_model extends CI_Model {

  function __construct()
  {
    parent::__construct();

  }



 /** ******************************************************************
  * Function 'get_dokument'
  * 
  * Get record with id=n.
  * 
  * @param  integer $id                       primary key
  * 
  * @throws Exception($kl_messages[4], 4)     Invalid input parameter(s)
  * @throws Exception($kl_messages[5], 5)     Undefined database error
  *
  * @return array   $out                      specified record as array  
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
      /** Create the query string. */
      $sql_str = 'SELECT * FROM clique.v_r_dokumente WHERE id=';
//      $sql_str = 'SELECT * FROM clique.v_dokumente WHERE id=';
      
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

      /** Query the database. */
      $query = $this->db->query($sql_str);
      $out = $query->result();

      // Debug
      $this->firephp->log($out, '[Dokument_model-> get_dokument: $out: ');
      $this->firephp->log(count($out), '[Dokument_model-> get_dokument: count($out): ');
    }
    catch (Exception $e) 
    {
      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    
    // Debug
    $this->firephp->log($out, '[get: $out: ');
    
    return $out;
  }
  


 /** ******************************************************************
  * Function 'get_all_dokumente'
  * 
  * Reads all or a defined number records from database. 
  * 
  * @param  integer $num                      number of records to read
  * @param  integer $start                    index of first reacord to read
  * 
  * @throws Exception($kl_messages[5], 5)     Undefined database error
  * 
  * @return array   $out                      read records as array  
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
      /** Create the query string. */
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
      $out = $query->result();
      
      // Debug
      $this->firephp->log($out, '[Dokument_model-> get_all_dokumente: $out: ');
      $this->firephp->log(count($out), '[Dokument_model-> get_all_dokumente: count($out): ');
    }
    catch (Exception $e) 
    {
      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    
    // Debug
    $this->firephp->log($out, '[get: $out: ');
    
    return $out;
  }



 /** ******************************************************************
  * Function 'create_dokument'
  * 
  * Creates new record in database.
  * Uses active records.
  * 
  * @param  array   $data                     data to store = data of the new record
  * 
  * @throws Exception($kl_messages[5], 5)     Undefined database error
  * 
  * @return boolean                           indicates success of operation 
  * 
  */ 
  function create_dokument($input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Dokument_model-> create_dokument: started ... ');
    $this->firephp->log($input_data, 'Dokument_model-> create_dokument:  $input_data');
    echo ('[Dokument_model-> create_dokument: $input_data: ' . $input_data);
    
    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Dokument_model-> create_dokument: $data: ');
      
      /** INSERT new record. */
      //      
      $s = $this->config->item('db_schema') . '.dokumente';
      $this->db->insert($s, $data);

      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Dokument_model-> create_dokument: $errnum: ');
      $this->firephp->log($errmsg, '[Dokument_model-> create_dokument: $errmsg: ');
      echo ('[Dokument_model-> create_dokument: $errnum: ' . $errnum);
      echo ('[Dokument_model-> create_dokument: $errmsg: \'' . $errmsg . '\'');
      echo ('[Dokument_model-> create_dokument: $affected_rows: ' . $affected_rows);

      if (!$errnum && $affected_rows == 1) {
        $success = TRUE;
      }
      else {
        $success = FALSE;        
      }
    }
    catch (Exception $e) 
    {
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> create_dokument: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    
    // Debug
    $this->firephp->log('Dokument_model-> create_dokument: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'update_dokument'
  * 
  * Updates a record whith id=n with new data.
  * 
  * @param  integer $id                       primary key
  * @param  array   $data                     data to store = data of the new record
  * 
  * @throws Exception($kl_messages[5], 5)     Undefined database error
  * 
  * @return boolean                           indicates success of operation 
  * 
  */ 
  function update_dokument($id, $input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Dokument_model-> update_dokument: started ... ');
    $this->firephp->log($id, 'Dokument_model-> update_dokument:  $id');
    $this->firephp->log($input_data, 'Dokument_model-> update_dokument:  $input_data');

    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Dokument_model-> update_dokument: $data: ');
      
      /** UPDATE specified record. */
      //      
      $s = $this->config->item('db_schema') . '.dokumente';
      
      $this->db->where('id', $id);
      $this->db->update($s, $data);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Dokument_model-> update_dokument: $errnum: ');
      $this->firephp->log($errmsg, '[Dokument_model-> update_dokument: $errmsg: ');
      echo ('[Dokument_model-> update_dokument: $errnum: ' . $errnum);
      echo ('[Dokument_model-> update_dokument: $errmsg: \'' . $errmsg . '\'');
      echo ('[Dokument_model-> update_dokument: $affected_rows: ' . $affected_rows);

      if (!$errnum && $affected_rows == 1) {
        $success = TRUE;
      }
      else {
        $success = FALSE;        
      }
    }
    catch (Exception $e) 
    {
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> update_dokument: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }

    // Debug
    $this->firephp->log('Dokument_model-> update_dokument: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'delete_dokument'
  * 
  * Delete record with id=n.
  * 
  * @param  integer $id                       primary key
  * 
  * @throws Exception($kl_messages[5], 5)     Undefined database error
  * 
  * @return boolean                           indicates success of operation 
  * 
  */ 
  function delete_dokument($id)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Dokument_model-> delete_dokument: started ... ');
    $this->firephp->log($id, 'Dokument_model-> delete_dokument:  $id');

    try
    {
      /** DELETE specified record. */
      //
      $s = $this->config->item('db_schema') . '.dokumente';
      
      $this->db->where('id', $id);
      $this->db->delete($s);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Dokument_model-> delete_dokument: $errnum: ');
      $this->firephp->log($errmsg, '[Dokument_model-> delete_dokument: $errmsg: ');
      echo ('[Dokument_model-> delete_dokument: $errnum: ' . $errnum);
      echo ('[Dokument_model-> delete_dokument: $errmsg: \'' . $errmsg . '\'');
      echo ('[Dokument_model-> delete_dokument: $affected_rows: ' . $affected_rows);

      if (!$errnum && $affected_rows == 1) {
        $success = TRUE;
      }
      else {
        $success = FALSE;        
      }
       
    }
    catch (Exception $e) 
    {
      // Debug
      $this->firephp->log($sql_str, '[Dokument_model-> update_dokument: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    

    // Debug
    $this->firephp->log('Dokument_model-> delete_dokument: ... finishing.');
    
    return $success;    
  }
  
}


/* End of file dokument_model.php */
/* Location: ./application/model/dokument_model.php */