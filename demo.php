<?php
	// Include file to webpage
	include('sc_highlighting.php');
	
	// Add link to formatting stylesheet (argument adds prepath)
	sc_add_stylesheet();
	
	// Run function to add highlighting
	sc_highlighter("sc_code/demo.scd");
?>