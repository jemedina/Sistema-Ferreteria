<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'rfc') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'a_paterno') ||
        !property_exists($request,'a_materno') ||
        !property_exists($request,'email') ||
		!property_exists($request,'telefono') ||
		!property_exists($request,'calle') ||
		!property_exists($request,'colonia') ||
        !property_exists($request,'num_domicilio_ext') ||
		!property_exists($request,'cp') ||
		!property_exists($request,'cve_mun') ||
		!property_exists($request,'cve_ent')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}


	$num_domicilio_int = "NULL";
	if(property_exists($request,'num_domicilio_int')) {
		$num_domicilio_int = "'".$request->num_domicilio_int."'";
	}

	$sql = "
		INSERT INTO 
		cliente
		SET 
		RFC = $request->rfc,
		nombre='$request->nombre',
        a_paterno='$request->a_paterno',
        a_materno='$request->a_materno',
		email='$request->email',
		telefono='$request->telefono',
		calle='$request->calle',
		colonia='$request->colonia',
        num_domicilio_ext='$request->num_domicilio_ext',
		num_domicilio_int=$num_domicilio_int,
		cp='$request->cp',
		cve_mun='$request->cve_mun',
		cve_ent='$request->cve_ent';"; 

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ");
	}
?>