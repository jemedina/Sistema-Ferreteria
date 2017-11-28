<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'no_catalogo') ||
		!property_exists($request,'anio') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'id_prov')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}

	$sql = "
		INSERT INTO 
		catalogo
		SET 
		id_prov = '$request->id_prov',
        nombre='$request->nombre',
        anio=$request->anio,
        no_catalogo=$request->no_catalogo;"; 

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ");
	}
?>