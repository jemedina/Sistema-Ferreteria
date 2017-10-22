<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'nombre') ||
		!property_exists($request,'a_paterno') ||
		!property_exists($request,'a_materno') ||
		!property_exists($request,'correo') ||
		!property_exists($request,'telefono') ||
		!property_exists($request,'f_nac') ||
		!property_exists($request,'f_ingreso') ||
		!property_exists($request,'puesto') ||
		!property_exists($request,'calle') ||
		!property_exists($request,'colonia') ||
		!property_exists($request,'num_domicilio_ext') ||
		!property_exists($request,'cp') ||
		!property_exists($request,'cve_mun') ||
		!property_exists($request,'cve_ent')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}

	//Obtener el último id
	$res1 = $con->query("SELECT IFNULL( MAX(id_empleado), 0) as lastid FROM empleado;");
	if($row = mysqli_fetch_assoc($res1)) {
		$lastid = $row['lastid'] + 1;
	}

	$sql = "
		INSERT INTO 
		empleado VALUES (
		$lastid,
		'$request->nombre',
		'$request->a_paterno',
		'$request->a_materno',
		'$request->correo',
		'$request->telefono',
		'$request->f_nac',
		'$request->f_ingreso',
		'$request->puesto',
		'$request->calle',
		'$request->colonia',
		'$request->num_domicilio_int',
		'$request->num_domicilio_ext',
		'$request->cp',
		'$request->cve_mun',
		'$request->cve_ent')";
	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta");
	} else {
		echoError("Error al guardar el registro: ".$sql);
	}
?>