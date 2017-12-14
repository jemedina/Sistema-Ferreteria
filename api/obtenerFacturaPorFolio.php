<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
	$sql = "
	 SELECT no_folio, fecha_factura, fecha_limite_pago, no_orden,fecha_orden from
	 factura where no_folio='$request->id';";

	$result = $con->query($sql);
	if($result) {
		echoMysqlResults($result);	
	}
	else {
		echoError("Error :(");
	}
?>