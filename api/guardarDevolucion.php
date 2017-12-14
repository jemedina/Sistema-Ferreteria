<?php
require_once 'config.php';

    $conteo=sizeof($request)-1;
    $venta=(explode(' ',$numeroVenta,2));
    $sql="insert into devolucion (no_devolucion,fecha,hora,no_venta,fecha_venta) values
    ('2',curdate(),curtime(),'$venta[0]','$venta[1]');";
    $con->query($sql);
    while($conteo>=0){
        $resp=$request->fetch_array(MYSQLI_NUM);
        $sql="insert into devolucion_producto (codigo,marca,no_devolucion,fecha,cantidad,unidades,motivo,descripcion) values
        ('$resp[0]','$resp[1]',curdate(),'$resp[3]','$resp[4]','$resp[5]','$resp[6]');";
        $con->query($sql);
    }


	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ".$sql);
	}
?>
