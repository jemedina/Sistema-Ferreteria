<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		echoError("Error: Falta la keyword");
	}
	$keyword = $_GET['keyword'];
	$sql = "SELECT concat(codigo,'||',marca) as cod, nombre AS nombreCompleto,precio_venta FROM producto where upper(nombre) like upper('%$keyword%') or codigo = '$keyword;'";
	
	$result = $con->query($sql);
	

	echoMysqlResults($result);
?>