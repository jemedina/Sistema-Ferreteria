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
		INSERT INTO `producto` (`codigo`, `marca`, `nombre`, `unidades_medicion`, `nombre_categoria`, `no_serie`, `descripcion`, `precio_venta`, `no_catalogo`, `anio`, `no_caja`, `no_seccion`, `no_estante`, `no_repisa`, `existencia_bodega`, `existencia_caja`, `existencia_repisa`, `limite_inferior`, `limite_superior`) 
			VALUES ('$request->codigo','$request->marca','$request->nombre','$request->unidades_medicion','$request->nombre_categoria','$request->no_serie','$request->descripcion','$request->precio_venta','$request->no_catalogo','$request->anio','$request->no_caja','$request->no_seccion','$request->no_estante','$request->no_repisa','$request->existencia_bodega','$request->existencia_caja','$request->existencia_repisa','$request->limite_inferior','$request->limite_superior');
			"; 

	$result = $con->query($sql);

	if($result){ 
		echoMessage("Insercion Correcta ");
	} else {
		echoError("Error al guardar el registro ".$sql);
	}
?>