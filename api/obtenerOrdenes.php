<?php 
	require_once 'config.php';
	
    $sql = "SELECT no_orden, fecha_orden FROM orden_compra order by fecha_orden desc;";
	$result = $con->query($sql);
	

	echoMysqlResults($result);
?>