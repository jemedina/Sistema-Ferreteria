<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		$sql = "SELECT ta.*,tb.id_prov,(ta.existencia_bodega + ta.existencia_caja + ta.existencia_repisa) as existencia_total FROM producto as ta, catalogo as tb WHERE ta.no_catalogo = tb.no_catalogo and ta.anio = tb.anio;";
	}else {
		$k = $_GET['keyword'];
		$sql = "SELECT ta.*,tb.id_prov,(ta.existencia_bodega + ta.existencia_caja + ta.existencia_repisa) as existencia_total FROM producto as ta, catalogo as tb WHERE ((upper(ta.nombre) like upper('%$k%')) OR (upper(ta.marca) like upper('%$k%')) OR ta.codigo = '$k') and ta.no_catalogo = tb.no_catalogo and ta.anio = tb.anio;";
	}
	$result = $con->query($sql);
	sleep(0.4);

	echoMysqlResults($result);
?>