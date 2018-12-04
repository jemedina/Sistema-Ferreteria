<?php 
	require_once 'config.php';
	$result = $con->query("SELECT * FROM caja inner join repisa");
	echoMysqlResults($result);
?>