<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
	$sql = "
	 SELECT concat(no_orden,fecha_orden) as id, fecha_orden, id_prov,no_orden from
	 orden_compra where concat(no_orden,fecha_orden)='$request->id';";

	$result = $con->query($sql);
	if($result) {
		echoMysqlResults($result);	
	}
	else {
		echoError("Error :(");
	}
?>