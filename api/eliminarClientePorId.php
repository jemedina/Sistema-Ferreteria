<?php 
	require_once 'config.php';
	$sql = "DELETE FROM cliente WHERE RFC = '$request->rfc'";
	$result = $con->query($sql);
	if($result)
		echoMessage("Proveedor eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>