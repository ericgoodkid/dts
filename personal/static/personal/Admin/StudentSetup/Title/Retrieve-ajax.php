<?php
	
	include('../../../config/connection.php');
	if( isset($_POST['_code']) )
	{
		$code = $_POST['_code'];
		
		$query = mysqli_query($con,"UPDATE `r_financial_assistance_title` SET FinAssiTitle_DISPLAY_STAT = 'Active',FinAssiTitle_DATE_MOD = CURRENT_TIMESTAMP WHERE FinAssiTitle_CODE = '$code'");

	}

?>
