<?php 
	require_once 'config.php';
	//USE FOR stored procedure guardar_caralogo
	//Automatiza la generacion del numero de catalogo
	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'anio') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'id_prov')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}

	$sql = "call guardar_catalogo($request->id_prov,'$request->nombre',$request->anio);"; 

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ");
	}
?>