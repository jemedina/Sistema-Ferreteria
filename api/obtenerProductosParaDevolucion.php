<?php
    require_once 'config.php';
    $sql="select codigo, marca, precio_vendido, cantidad, unidades from producto_venta where concat(no_venta, ' ', fecha)='1 2017-12-03'";
    $result = $con->query($sql);
	echoMysqlResults($result);
 
?>
