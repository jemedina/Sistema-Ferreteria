<?php 
		require_once 'config.php';
		$result = $con->query("call ultimo_no_venta;");
		$no_venta = intval($result->fetch_object()->no_venta);
		echo var_dump($no_venta);
?>