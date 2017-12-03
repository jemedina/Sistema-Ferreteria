<?php 
	require_once 'config.php';
	$sql = "DELETE FROM proveedor WHERE id_prov = $request->id";
	$result = $con->query($sql);
	if($result)
		echoMessage("Proveedor eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar ".$sql);
?>