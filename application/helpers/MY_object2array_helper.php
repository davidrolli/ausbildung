<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * @param array $array the array to be converted
 * @param string? $rootElement if specified will be taken as root element, otherwise defaults to
 *                <root>
 * @param SimpleXMLElement? if specified content will be appended, used for recursion
 * @return string XML version of $array
 */
 
function object2array($object)
{
  if (is_object($object))
  {
    foreach ($object as $key => $value)
    {
      $array[$key] = $value;
    }
  }
  else
  {
    $array = $object;
  }
  
  return $array;
}

/* End of 'MY_object2array_helper.php' */
/* Location: ./application/helpers/ */