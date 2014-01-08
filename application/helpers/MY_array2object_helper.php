<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * @param array $array the array to be converted
 * @param string? $rootElement if specified will be taken as root element, otherwise defaults to
 *                <root>
 * @param SimpleXMLElement? if specified content will be appended, used for recursion
 * @return string XML version of $array
 */
 
function array2object($array)
{
  if (is_array($array))
  {
    $obj = new StdClass();

    foreach ($array as $key => $val)
    {
      $obj->$key = $val;
    }
  }
  else
  {
    $obj = $array;
  }

  return $obj;
}
 
/* End of 'MY_array2object_helper.php' */
/* Location: ./application/helpers/ */