<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		echoError("Error: Falta la keyword");
	}
	$keyword = $_GET['keyword'];
	$result = $con->query("SELECT id_prov, nombre AS nombreCompleto FROM proveedor where nombre like '%$keyword%';");
	

	echoMysqlResults($result);
?>