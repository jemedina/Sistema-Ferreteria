<?php 
	require_once 'config.php';
	
	if(!isset($keyword)) {
		$sql = "SELECT concat(nombre,' [',anio,'] ') nombre AS nombreCompleto FROM catalogo;";
	} else {
		$keyword = $_GET['keyword'];
        $anio = $_GET['anio'];
		$sql = "SELECT concat(nombre,' [',anio,'] ') AS nombreCompleto FROM catalogo where nombre like '%$keyword%' and anio='$anio';";
	}
	$result = $con->query($sql);
	

	echoMysqlResults($result);
?>