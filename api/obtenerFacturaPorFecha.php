<?php 
	require_once 'config.php';
	//TODO: Validar que recibamos id_prov
    $fecha_factura1=new DateTime("@$request->fecha_factura1_timestamp"); 
    $fecha_factura2=new DateTime("@$request->fecha_factura2_timestamp"); 
	$sql = "
	SELECT no_folio, fecha_factura, monto from
	 factura where fecha_factura between'".$fecha_factura1->format('Y-m-d')."' and '".$fecha_factura2->format('Y-m-d')."' order by fecha_factura desc ;";

	$result = $con->query($sql);
	echoMysqlResults($result);
?>