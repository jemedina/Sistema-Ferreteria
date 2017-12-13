<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'fecha_orden') ||
		!property_exists($request,'id_prov')
	) {
		echoError("No se pudo guardar la orden: Parametros incompletos");
	}

    $fecha_orden=new DateTime("@$request->fecha_orden_timestamp"); 

    $no = "Select count(no_orden) as cont from orden_compra where fecha_orden='".$fecha_orden->format('Y-m-d')."';";
    $num = $con->query($no);
    $resultado=$num->fetch_array(MYSQLI_NUM); 
    $no_orden=$resultado[0]+1; 

	$sql = "
		INSERT INTO 
		orden_compra
		SET 
		id_prov = '$request->id_prov',
        fecha_orden='".$fecha_orden->format('Y-m-d')."',
        no_orden=$no_orden;"; 
  
	$result = $con->query($sql);
     
	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ".$sql);
	}
?>