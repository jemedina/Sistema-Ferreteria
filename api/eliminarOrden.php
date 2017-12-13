<?php 
	require_once 'config.php';
	$sql = "DELETE FROM orden_compra WHERE no_orden='$request->no_orden' and fecha_orden='$request->fecha_orden'; ";
	$result = $con->query($sql);
	if($result)
		echoMessage("Orden de compra eliminada satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>