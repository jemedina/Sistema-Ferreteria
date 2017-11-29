<?php 
	require_once 'config.php';
	/*$sql = "

		SELECT `RFC`, `nombre`, `a_paterno`, `a_materno`, `telefono`, `calle`, `colonia`, `num_domicilio_ext`, `num_domicilio_int`, `cp`, `cve_mun`, `cve_ent`, `correo`,  FROM cliente
		WHERE RFC = $request->rfc";*/
		if( !property_exists($request,'rfc') ){
			echoError("No se pudo guardar el usuario: Parametros incompletos");
		}
    $sql = "SELECT `RFC`, `nombre`, `a_paterno`, `a_materno`, `correo`, `telefono`, `calle`, `colonia`, `num_domicilio_int`, `num_domicilio_ext`, `cp`, `cve_mun`, `cve_ent` FROM `cliente` WHERE RFC = '$request->rfc'";

	$result = $con->query($sql);
	if($result) {
		echoMysqlResults($result);
	} 	else {
		echoError($sql);
	}
?>