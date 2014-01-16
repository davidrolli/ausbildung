<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/*
|--------------------------------------------------------------------------
| Special config file for the application "Ausbildung".
|--------------------------------------------------------------------------
|
*/

if (defined('ENVIRONMENT'))
{
  switch (ENVIRONMENT)
  {
    case 'development':
      $config['notizen_url'] = 'D:\Daten\Clique\Trommelinstruktion\Ausbildung\Davids_Notizen\NEU';
      $config['db_schema'] = 'clique';
    break;
  
    case 'testing':
    case 'production':
      $config['notizen_url'] = '..\Notizen';
      $config['db_schema'] = 'clique';
    break;

    default:
      exit('[config_ausbildung: The application environment is not set correctly.]');
  }
}

/* End of file config_ausbildung.php */
/* Location: ./application/config/config_ausbildung.php */