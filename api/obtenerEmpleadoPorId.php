<?php 
	require_once 'config.php';
	$sql = "
		SELECT 
		id_empleado, nombre, a_paterno, a_materno, correo, telefono, UNIX_TIMESTAMP(f_nac) as f_nac, UNIX_TIMESTAMP(f_ingreso) as f_ingreso, puesto, calle, colonia, num_domicilio_int, num_domicilio_ext, cp, cve_mun, cve_ent from empleado 
		WHERE id_empleado = $request->id";
	$result = $con->query($sql);
	echoMysqlResults($result);
?>