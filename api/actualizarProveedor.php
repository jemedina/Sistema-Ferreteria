<?php 
	require_once 'config.php';

	//Checar que recibimos los parametros obligatorios
	if(
        !property_exists($request,'id') ||
		!property_exists($request,'nombre') ||
		!property_exists($request,'razon_social') ||
		!property_exists($request,'telefono') ||
		!property_exists($request,'calle') ||
        !property_exists($request,'email') ||
		!property_exists($request,'colonia') ||
        !property_exists($request,'num_domicilio_ext') ||
		!property_exists($request,'cp') ||
		!property_exists($request,'cve_mun') ||
		!property_exists($request,'cve_ent')
	) {
		/*echoError("No se pudo guardar el proveedor: Parametros incompletos",$request->id," ",$request->nombre," ",$request->r_social," ",$request->telefono," ",$request->calle," ",$request->colonia," ",$request->email," ",$request->num_domicilio_ext," "+,request->cp," ",$request->cve_mun," ",$request->cve_ent); */
        echoError("No se pudo guardar el proveedor: Parametros incompletos"); 
	}

	$num_domicilio_int = "NULL";
	if(property_exists($request,'num_domicilio_int')) {
		$num_domicilio_int = "'".$request->num_domicilio_int."'";
	}
	
	
    
	$sql = "
		UPDATE 
		proveedor SET 
		nombre='$request->nombre',
		razon_social='$request->razon_social',
		telefono='$request->telefono',
		email='$request->email',
		calle='$request->calle',
		colonia='$request->colonia',
        num_domicilio_ext='$request->num_domicilio_ext',
		num_domicilio_int=$num_domicilio_int,
		cp='$request->cp',
		cve_mun='$request->cve_mun',
		cve_ent='$request->cve_ent' WHERE
		id_prov = $request->id";


	$result = $con->query($sql);

	if($result){ 
		echoMessage("Cambios guardados correctamente");
	} else {
		echoError("Error al guardar el registro: ".$sql);
	}
?>
