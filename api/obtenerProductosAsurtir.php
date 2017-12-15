<?php 
	require_once 'config.php';
    $sql = "SELECT codigo, marca, nombre, no_catalogo, anio, existencia_bodega, limite_inferior FROM producto where existencia_bodega<limite_inferior order by codigo,marca;";
	$result = $con->query($sql);
	echoMysqlResults($result);
?>