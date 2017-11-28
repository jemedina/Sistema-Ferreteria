<?php 
	require_once 'config.php';
	$sql = "DELETE FROM catalogo WHERE no_catalogo = '$request->no_catalogo' and anio = '$request->anio' ";
	$result = $con->query($sql);
	if($result)
		echoMessage("Catalogo eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>