<?php 
	require_once 'config.php';
	$sql = "
		SELECT 
		id_prov, nombre, razon_social, telefono, calle, colonia, num_domicilio_int, num_domicilio_ext, cp, cve_mun, cve_ent, email from proveedor WHERE id_prov = $request->id";
	$result = $con->query($sql);
	echoMysqlResults($result);
?>