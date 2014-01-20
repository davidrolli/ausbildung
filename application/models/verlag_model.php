<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');


/** ******************************************************************
 * Class 'Verlag_model'
 * 
 * @author      David Rolli, Bottmingen, Switzerland
 * @copyright   RBrains 2014
 * @version     1.0
 * 
 * @category    Clique
 * @package     Ausbildung
 * 
 */ 

class Verlag_model extends CI_Model {

  function __construct()
  {
    parent::__construct();

  }



 /** ******************************************************************
  * Function 'get_verlag'
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
  function get_verlag($id)
  {
    global $kl_messages;
    global $http_messages;    
        
    // Debug
    $this->firephp->log('Verlag_model-> get_verlag: started ... ');
    $this->firephp->log($id, 'Verlag_model-> get_verlag:  $id');

    try
    {
      /** Create the query string. */
      $sql_str = 'SELECT * FROM clique.v_verlage WHERE id=';
      
      // Debug
      $this->firephp->log($sql_str, '[Verlag_model-> get_verlag: $sql_str: ');

      if ($id && is_int((int)$id)) {
        $sql_str .= $id;
      }
      else {
        throw new Exception($kl_messages[4], 4);     // Wrong input parameter.
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Verlag_model-> get_verlag: $sql_str: ');

      /** Query the database. */
      $query = $this->db->query($sql_str);
      $out = $query->result();

      // Debug
      $this->firephp->log($out, '[Verlag_model-> get_verlag: $out: ');
      $this->firephp->log(count($out), '[Verlag_model-> get_verlag: count($out): ');
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
  * Function 'get_all_verlage'
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
  function get_all_verlage($num, $start)
  {
    // Debug
    $this->firephp->log('Verlag_model-> get_all_verlage: started ... ');
    $this->firephp->log($num, 'Verlag_model-> get_all_verlage:  $num');
    $this->firephp->log($start, 'Verlag_model-> get_all_verlage:  $start');

    try
    {
      /** Create the query string. */
      $sql_str = 'SELECT * FROM clique.v_verlage';

      if ($num) {
        $sql_str .= " LIMIT " . $num;
      }
      
      if ($start) {
        $sql_str .= " OFFSET " . $start;
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Verlag_model-> get_all_verlage: $sql_str: ');

      $query = $this->db->query($sql_str);
  
      $out = array();
      $out = $query->result();
      
      // Debug
      $this->firephp->log($out, '[Verlag_model-> get_all_verlage: $out: ');
      $this->firephp->log(count($out), '[Verlag_model-> get_all_verlage: count($out): ');
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
  * Function 'create_verlag'
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
  function create_verlag($input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Verlag_model-> create_verlag: started ... ');
    $this->firephp->log($input_data, 'Verlag_model-> create_verlag:  $input_data');

    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Verlag_model-> create_verlag: $data: ');
      
      /** INSERT new record. */
      //      
      $s = $this->config->item('db_schema') . '.verlage';
      $this->db->insert($s, $data);

      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Verlag_model-> create_verlag: $errnum: ');
      $this->firephp->log($errmsg, '[Verlag_model-> create_verlag: $errmsg: ');
      echo ('[Verlag_model-> create_verlag: $errnum: ' . $errnum);
      echo ('[Verlag_model-> create_verlag: $errmsg: \'' . $errmsg . '\'');
      echo ('[Verlag_model-> create_verlag: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Verlag_model-> create_verlag: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    
    // Debug
    $this->firephp->log('Verlag_model-> create_verlag: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'update_verlag'
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
  function update_verlag($id, $input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Verlag_model-> update_verlag: started ... ');
    $this->firephp->log($id, 'Verlag_model-> update_verlag:  $id');
    $this->firephp->log($input_data, 'Verlag_model-> update_verlag:  $input_data');

    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Verlag_model-> update_verlag: $data: ');
      
      /** UPDATE specified record. */
      //      
      $s = $this->config->item('db_schema') . '.verlage';
      
      $this->db->where('id', $id);
      $this->db->update($s, $data);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Verlag_model-> update_verlag: $errnum: ');
      $this->firephp->log($errmsg, '[Verlag_model-> update_verlag: $errmsg: ');
      echo ('[Verlag_model-> update_verlag: $errnum: ' . $errnum);
      echo ('[Verlag_model-> update_verlag: $errmsg: \'' . $errmsg . '\'');
      echo ('[Verlag_model-> update_verlag: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Verlag_model-> update_verlag: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }

    // Debug
    $this->firephp->log('Verlag_model-> update_verlag: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'delete_verlag'
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
  function delete_verlag($id)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Verlag_model-> delete_verlag: started ... ');
    $this->firephp->log($id, 'Verlag_model-> delete_verlag:  $id');

    try
    {
      /** DELETE specified record. */
      //
      $s = $this->config->item('db_schema') . '.verlage';
      
      $this->db->where('id', $id);
      $this->db->delete($s);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Verlag_model-> delete_verlag: $errnum: ');
      $this->firephp->log($errmsg, '[Verlag_model-> delete_verlag: $errmsg: ');
      echo ('[Verlag_model-> delete_verlag: $errnum: ' . $errnum);
      echo ('[Verlag_model-> delete_verlag: $errmsg: \'' . $errmsg . '\'');
      echo ('[Verlag_model-> delete_verlag: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Verlag_model-> update_verlag: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    

    // Debug
    $this->firephp->log('Verlag_model-> delete_verlag: ... finishing.');
    
    return $success;    
  }
  
}


/* End of file verlag_model.php */
/* Location: ./application/model/verlag_model.php */