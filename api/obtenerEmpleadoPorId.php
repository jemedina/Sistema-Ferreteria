<?php 
	require_once 'config.php';
	$sql = "SELECT * FROM empleado WHERE id_empleado = $request->id";
	$result = $con->query($sql);
	echoMysqlResults($result);
?>