<?php
    require_once 'config.php';
    $sql="select a.codigo, a.marca, a.precio_vendido, a.cantidad, a.unidades, b.nombre from producto_venta a,producto b where concat(no_venta, ' ', fecha)='$request->id' and a.codigo=b.codigo";
    $result = $con->query($sql);
	echoMysqlResults($result);
 
?>
