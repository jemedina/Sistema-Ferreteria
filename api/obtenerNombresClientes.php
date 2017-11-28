<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		echoError("Error: Falta la keyword");
	}
	$keyword = $_GET['keyword'];
	$result = $con->query("SELECT RFC, concat(nombre, ' ', a_paterno, ' ', a_materno) AS nombreCompleto FROM cliente where nombre like '%$keyword%';");
	

	echoMysqlResults($result);
?>