<?php 
	require_once 'config.php';
	$fecha = new DateTime("@$request->fecha");
	$result = $con->query("call obtener_ventas_por_fecha('".$fecha->format('Y-m-d')."')");
	echoMysqlResults($result);
?>