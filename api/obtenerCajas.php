<?php 
	require_once 'config.php';
	$result = $con->query("SELECT * FROM caja");
	echoMysqlResults($result);
?>