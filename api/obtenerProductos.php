<?php 
	require_once 'config.php';
	if(!isset($_GET['keyword'])) 
	{
		$sql = "SELECT * FROM productosexistencias ;";
	}else {
		$k = $_GET['keyword'];
		$sql = "SELECT * FROM productosexistencias WHERE ((upper(nombre) like upper('%$k%')) OR (upper(marca) like upper('%$k%')) OR codigo = '$k');";
	}
	$result = $con->query($sql);
	sleep(0.4);

	echoMysqlResults($result);
?>