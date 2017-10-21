<?php 
	require_once 'config.php';
	$result = $con->query("SELECT cve_ent,nom_ent,nom_abr FROM entidad;");
	echoMysqlResults($result);
?>