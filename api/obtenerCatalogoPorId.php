<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
	$sql = "
	 SELECT concat(no_catalogo,anio) as id, nombre, anio, id_prov,no_catalogo from
	 catalogo where concat(no_catalogo,anio)='$request->id';";

	$result = $con->query($sql);
	if($result) {
		echoMysqlResults($result);	
	}
	else {
		echoError("Error :(");
	}
?>