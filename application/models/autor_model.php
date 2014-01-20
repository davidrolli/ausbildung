<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');


/** ******************************************************************
 * Class 'Autor_model'
 * 
 * @author      David Rolli, Bottmingen, Switzerland
 * @copyright   RBrains 2014
 * @version     1.0
 * 
 * @category    Clique
 * @package     Ausbildung
 * 
 */ 

class Autor_model extends CI_Model {

  function __construct()
  {
    parent::__construct();

  }



 /** ******************************************************************
  * Function 'get_autor'
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
  function get_autor($id)
  {
    global $kl_messages;
    global $http_messages;    
        
    // Debug
    $this->firephp->log('Autor_model-> get_autor: started ... ');
    $this->firephp->log($id, 'Autor_model-> get_autor:  $id');

    try
    {
      /** Create the query string. */
      $sql_str = 'SELECT * FROM clique.v_autoren WHERE id=';
      
      // Debug
      $this->firephp->log($sql_str, '[Autor_model-> get_autor: $sql_str: ');

      if ($id && is_int((int)$id)) {
        $sql_str .= $id;
      }
      else {
        throw new Exception($kl_messages[4], 4);     // Wrong input parameter.
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Autor_model-> get_autor: $sql_str: ');

      /** Query the database. */
      $query = $this->db->query($sql_str);
      $out = $query->result();

      // Debug
      $this->firephp->log($out, '[Autor_model-> get_autor: $out: ');
      $this->firephp->log(count($out), '[Autor_model-> get_autor: count($out): ');
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
  * Function 'get_all_autoren'
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
  function get_all_autoren($num, $start)
  {
    // Debug
    $this->firephp->log('Autor_model-> get_all_autoren: started ... ');
    $this->firephp->log($num, 'Autor_model-> get_all_autoren:  $num');
    $this->firephp->log($start, 'Autor_model-> get_all_autoren:  $start');

    try
    {
      /** Create the query string. */
      $sql_str = 'SELECT * FROM clique.v_autoren';

      if ($num) {
        $sql_str .= " LIMIT " . $num;
      }
      
      if ($start) {
        $sql_str .= " OFFSET " . $start;
      }
      
      // Debug
      $this->firephp->log($sql_str, '[Autor_model-> get_all_autoren: $sql_str: ');

      $query = $this->db->query($sql_str);
  
      $out = array();
      $out = $query->result();
      
      // Debug
      $this->firephp->log($out, '[Autor_model-> get_all_autoren: $out: ');
      $this->firephp->log(count($out), '[Autor_model-> get_all_autoren: count($out): ');
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
  * Function 'create_autor'
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
  function create_autor($input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Autor_model-> create_autor: started ... ');
    $this->firephp->log($input_data, 'Autor_model-> create_autor:  $input_data');

    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Autor_model-> create_autor: $data: ');
      
      /** INSERT new record. */
      //      
      $s = $this->config->item('db_schema') . '.autoren';
      $this->db->insert($s, $data);

      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Autor_model-> create_autor: $errnum: ');
      $this->firephp->log($errmsg, '[Autor_model-> create_autor: $errmsg: ');
      echo ('[Autor_model-> create_autor: $errnum: ' . $errnum);
      echo ('[Autor_model-> create_autor: $errmsg: \'' . $errmsg . '\'');
      echo ('[Autor_model-> create_autor: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Autor_model-> create_autor: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    
    // Debug
    $this->firephp->log('Autor_model-> create_autor: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'update_autor'
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
  function update_autor($id, $input_data)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Autor_model-> update_autor: started ... ');
    $this->firephp->log($id, 'Autor_model-> update_autor:  $id');
    $this->firephp->log($input_data, 'Autor_model-> update_autor:  $input_data');

    try
    {
      $data = $input_data;
      
      // Debug
      $this->firephp->log($data, '[Autor_model-> update_autor: $data: ');
      
      /** UPDATE specified record. */
      //      
      $s = $this->config->item('db_schema') . '.autoren';
      
      $this->db->where('id', $id);
      $this->db->update($s, $data);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Autor_model-> update_autor: $errnum: ');
      $this->firephp->log($errmsg, '[Autor_model-> update_autor: $errmsg: ');
      echo ('[Autor_model-> update_autor: $errnum: ' . $errnum);
      echo ('[Autor_model-> update_autor: $errmsg: \'' . $errmsg . '\'');
      echo ('[Autor_model-> update_autor: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Autor_model-> update_autor: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }

    // Debug
    $this->firephp->log('Autor_model-> update_autor: ... finishing.');
    
    return $success;
  }



 /** ******************************************************************
  * Function 'delete_autor'
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
  function delete_autor($id)
  {
    $success = NULL;
    
    // Debug
    $this->firephp->log('Autor_model-> delete_autor: started ... ');
    $this->firephp->log($id, 'Autor_model-> delete_autor:  $id');

    try
    {
      /** DELETE specified record. */
      //
      $s = $this->config->item('db_schema') . '.autoren';
      
      $this->db->where('id', $id);
      $this->db->delete($s);
      
      $errnum = $this->db->_error_number();
      $errmsg = $this->db->_error_message();
      $affected_rows = $this->db->affected_rows();

      // Debug
      $this->firephp->log($errnum, '[Autor_model-> delete_autor: $errnum: ');
      $this->firephp->log($errmsg, '[Autor_model-> delete_autor: $errmsg: ');
      echo ('[Autor_model-> delete_autor: $errnum: ' . $errnum);
      echo ('[Verlag_model-> delete_autor: $errmsg: \'' . $errmsg . '\'');
      echo ('[Verlag_model-> delete_autor: $affected_rows: ' . $affected_rows);

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
      $this->firephp->log($sql_str, '[Verlag_model-> update_autor: caught an exception ! ');

      throw new Exception($kl_messages[5], 5);     // Undefined database error.
    }
    

    // Debug
    $this->firephp->log('Verlag_model-> delete_autor: ... finishing.');
    
    return $success;    
  }
  
}


/* End of file autor_model.php */
/* Location: ./application/model/autor_model.php */