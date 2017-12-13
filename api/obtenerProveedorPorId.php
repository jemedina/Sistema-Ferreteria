<?php 
	require_once 'config.php';
	//Uso de la vista proveedoresporid
	$sql = "

		SELECT * from proveedoresporid
		WHERE id_prov = $request->id";

	$result = $con->query($sql);
	echoMysqlResults($result);
?>