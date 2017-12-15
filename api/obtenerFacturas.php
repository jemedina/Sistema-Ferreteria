<?php 
	require_once 'config.php';
	
    $sql = "SELECT no_folio, facha_factura, fecha_limite_pago, monto, no_orden, fecha_orden FROM factura;";
	$result = $con->query($sql);
	

	echoMysqlResults($result);
?>