<?php 
	require_once 'config.php';
	$sql = "

		SELECT `RFC`, `nombre`, `a_paterno`, `a_materno`, `telefono`, `calle`, `colonia`, `num_domicilio_ext`, `num_domicilio_int`, `cp`, `cve_mun`, `cve_ent`, `email`,  FROM proveedor
		WHERE RFC = $request->rfc";

	$result = $con->query($sql);
	echoMysqlResults($result);
?>