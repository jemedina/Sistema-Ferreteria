<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'id_prov') ||
		!property_exists($request,'f_ultima__visita_timestamp') ||
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}


	$sql = "
		UPDATE 
		proveedor SET 
		SET 
		fecha_ultima_visita='$request->fecha_ultima_visita'
		WHERE id_prov='$request->id_prov";
	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro");
	}
?>