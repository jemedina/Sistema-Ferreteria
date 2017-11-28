<?php 
	require_once 'config.php';
	
	if(!isset($keyword)) {
		$sql = "SELECT id_prov, nombre AS nombreCompleto FROM proveedor;";
	} else {
		$keyword = $_GET['keyword'];
		$sql = "SELECT id_prov, nombre AS nombreCompleto FROM proveedor where nombre like '%$keyword%';";
	}
	$result = $con->query($sql);
	

	echoMysqlResults($result);
?>