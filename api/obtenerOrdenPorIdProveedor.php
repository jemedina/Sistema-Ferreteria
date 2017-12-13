<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
	$sql = "
	SELECT concat(no_orden,fecha_orden) as id, fecha_orden, no_orden from
	 orden_compra where id_prov='$request->id_prov';";

	$result = $con->query($sql);
	echoMysqlResults($result);
?>