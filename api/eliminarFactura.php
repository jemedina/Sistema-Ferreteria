<?php 
	require_once 'config.php';
	$sql = "DELETE FROM factura WHERE no_folio='$request->no_folio'; ";
	$result = $con->query($sql);
	if($result)
		echoMessage("Factura eliminada satisfactoriamente");
	else
		echoError("Se produjo un error al intentar eliminar");
?>