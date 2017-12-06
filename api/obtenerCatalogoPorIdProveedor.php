<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
	$sql = "
	SELECT concat(no_catalogo,anio) as id, nombre, anio, no_catalogo from
	 catalogo where id_prov='$request->id_prov';";

	$result = $con->query($sql);
	echoMysqlResults($result);
?>