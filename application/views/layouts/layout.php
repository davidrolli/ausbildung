<!DOCTYPE html>
<html>

  <head>
    <meta charset="utf-8">
    <title>Template with Bootstrap</title>

<!--    <link rel="stylesheet" href="/css/reset.css" type="text/css" media="screen" title="no title" charset="utf-8"/>  -->

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="/libs/js/bootstrap/css/bootstrap-responsive.min.css" type="text/css">    

  </head>

  <body>
    <div class="container">
    	<header class="highlite">
    	  <h1><a href="<?php echo site_url(); ?>"></a></h1>
    	  <ul class="nav">
          <li><a href="<?php echo site_url(); ?>"></a>Home</li>
          <li><a href="<?php echo site_url('questions/listing'); ?>"></a>Questions</li>
    	  </ul>
    	</header>
    	<div class="main"></div>
    	   LOAD SUBVIEW
    	<footer>
    	  &copy; <?php echo date('Y'); ?> Rabarber
    	</footer>
    </div>

    <script src="/libs/js/jquery/jquery-1.10.2.min.js"></script>
    <script src="/libs/js/bootstrap/js/bootstrap.min.js"></script>    

  </body>
  
</html>
