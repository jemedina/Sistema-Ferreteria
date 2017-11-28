<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
        !property_exists($request,'no_catalogo') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'anio')
	) {
        echoError("No se pudo guardar el catalogo: Parametros incompletos"); 
	}

	
    
	$sql = "
		UPDATE 
		catalogo SET 
		nombre='$request->nombre' WHERE
		no_catalogo = '$request->no_catalogo' and anio= '$request->anio'";

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Cambios guardados correctamente");
	} else {
		echoError("Error al guardar el registro: ".$sql);
	}
?>
