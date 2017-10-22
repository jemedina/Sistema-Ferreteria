<?php 
	require_once 'config.php';
	$sql = "DELETE FROM empleado WHERE id_empleado = $request->id";
	$result = $con->query($sql);
	if($result)
		echoMessage("Usuario eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>