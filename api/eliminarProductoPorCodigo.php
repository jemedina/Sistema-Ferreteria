<?php 
	require_once 'config.php';
	$sql = "DELETE FROM producto WHERE codigo = '$request->id'";
	$result = $con->query($sql);
	if($result)
		echoMessage("Producto eliminado satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>