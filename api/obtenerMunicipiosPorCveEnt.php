<?php 
	require_once 'config.php';
	$result = $con->query("SELECT cve_mun,nom_mun FROM municipio WHERE cve_ent=$request->cve_ent;");
	echoMysqlResultsNoMandatory($result);
?>