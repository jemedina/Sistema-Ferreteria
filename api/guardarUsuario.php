<?php 
	require_once 'config.php';

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