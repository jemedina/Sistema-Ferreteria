<?php 
	require_once 'config.php';
	$sql = "DELETE FROM catalogo WHERE concat(no_catalogo,anio)='$request->id'; ";
	$result = $con->query($sql);
	if($result)
		echoMessage("Catalogo eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>