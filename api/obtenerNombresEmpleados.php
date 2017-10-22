<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		echoError("Error: Falta la keyword");
	}
	$keyword = $_GET['keyword'];
	$result = $con->query("SELECT id_empleado, CONCAT(nombre,' ',a_paterno,' ',a_materno) AS nombreCompleto FROM empleado where CONCAT(nombre,' ',a_paterno,' ',a_materno) like '%$keyword%';");
	

	echoMysqlResults($result);
?>