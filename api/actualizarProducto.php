<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
		!property_exists($request,'codigo') ||
		!property_exists($request,'marca') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'unidades_medicion') ||
		!property_exists($request,'nombre_categoria') ||
		!property_exists($request,'descripcion') ||
		!property_exists($request,'precio_venta') ||
		!property_exists($request,'no_catalogo') ||
		!property_exists($request,'existencia_bodega') ||
		!property_exists($request,'limite_inferior') ||
		!property_exists($request,'anio') ||
		!property_exists($request,'limite_superior')
	) {
		echoError("No se pudo guardar el usuario: Parametros incompletos");
	}

	$sql = "
		UPDATE `producto` SET marca = '$request->marca', nombre = '$request->nombre', unidades_medicion = '$request->unidades_medicion', nombre_categoria = '$request->nombre_categoria', no_serie = '$request->no_serie', descripcion = '$request->descripcion', precio_venta = '$request->precio_venta', no_catalogo = '$request->no_catalogo', anio = '$request->anio', no_caja = '$request->no_caja', no_seccion = '$request->no_seccion', no_estante = '$request->no_estante', no_repisa = '$request->no_repisa', existencia_bodega = '$request->existencia_bodega', existencia_caja = '$request->existencia_caja', existencia_repisa = '$request->existencia_repisa', limite_inferior = '$request->limite_inferior', limite_superior = '$request->limite_superior'
			WHERE codigo = '$request->codigo';"; 

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Actualizacion Correcta ");
	} else {
		echoError("Error al guardar el registro ");
	}
?>