<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
        !property_exists($request,'id') ||
		!property_exists($request,'nombre')
	) {
        echoError("No se pudo guardar el catalogo: Parametros incompletos"); 
	}

	
    
	$sql = "
		UPDATE 
		catalogo SET 
		nombre='$request->nombre' WHERE
		concat(no_catalogo,anio) = '$request->id';";

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Cambios guardados correctamente");
	} else {
		echoError("Error al guardar el registro: ".$sql);
	}
?>
