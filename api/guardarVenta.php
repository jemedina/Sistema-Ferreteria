<?php 
	require_once 'config.php';
	
	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'no_venta') ||
		!property_exists($request,'fecha') ||
		!property_exists($request,'hora') ||
		!property_exists($request,'monto') ||
		!property_exists($request,'tipo') ||
		!property_exists($request,'id_empleado')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}
	$RFC = property_exists($request, 'RFC')?"'".$request->RFC."'":"null";
	$es_a_credito = property_exists($request, 'es_a_credito')?$request->es_a_credito:false;
	$fecha = new DateTime("@$request->fecha");
	$fecha_limite_pago = new DateTime("@$request->fecha_limite_pago_timestamp");
	
	$sql = "
		INSERT INTO `venta` (`no_venta`, `fecha`, `hora`, `monto`, `tipo`, `es_a_credito`, `descuento`, `fecha_limite_pago`, `id_empleado`, `RFC`) VALUES ('$request->no_venta', '".$fecha->format('Y-m-d')."', '$request->hora', '$request->monto', '$request->tipo', '$es_a_credito', '$request->descuento', '".$fecha_limite_pago->format('Y-m-d')."', '$request->id_empleado', $RFC);
		"; 
	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ".$sql);
	}
?>