<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'no_folio') ||
		!property_exists($request,'fecha_factura') ||
		!property_exists($request,'monto') ||
        !property_exists($request,'no_orden') ||
		!property_exists($request,'fecha_orden') 
	) {
		echoError("No se pudo guardar la factura: Parametros incompletos");
	}

     $fecha_factura=new DateTime("@$request->fecha_factura_timestamp"); 
if (!property_exists($request,'fecha_limite_pago') or $request->fecha_limite_pago == null){
    $sql = "
		INSERT INTO 
		factura
		SET 
		no_folio = '$request->no_folio',
        fecha_factura='".$fecha_factura->format('Y-m-d')."',
        fecha_limite_pago=NULL,
        no_orden='$request->no_orden',
        fecha_orden='$request->fecha_orden',
        monto=$request->monto;";  
}else{
    $fecha_limite_pago=new DateTime("@$request->fecha_limite_pago_timestamp"); 
    $sql = "
		INSERT INTO 
		factura
		SET 
		no_folio = '$request->no_folio',
        fecha_factura='".$fecha_factura->format('Y-m-d')."',
        fecha_limite_pago='".$fecha_limite_pago->format('Y-m-d')."',
        no_orden='$request->no_orden',
        fecha_orden='$request->fecha_orden',
        monto=$request->monto;";   
} 
	

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ".$sql);
	}
?>