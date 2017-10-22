<?php 

	$env = "local"; //Cambiar local | prod


	function writeDefaultHeaders() {
		header($_SERVER['SERVER_PROTOCOL'] . 'OK', true, 200);
		header("Access-Control-Allow-Origin: *");
		header("Content-Type: application/json; charset=UTF-8");
		header("Access-Control-Allow-Methods: POST, GET");
		header("Access-Control-Max-Age: 3600");
		header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
	}

	function echoError($msg) {
		header($_SERVER['SERVER_PROTOCOL'] . 'Internal Server Error', true, 500);
		$response = array();
		$response["msg"] = $msg;
		echo json_encode($response);
		exit();
	}
	function echoMessage($msg) {
		$response = array();
		$response["msg"] = $msg;
		echo json_encode($response);
	}

	function echoMysqlResults($result) {
		$rows = array();
		while($r = mysqli_fetch_assoc($result)) {
		    $rows[] = $r;
		}
		echo json_encode($rows);
	}

	$config = array();
	//Configuracion servidor local
	$config["local"] = array(); 
	$config["local"]["host"] = "localhost";
	$config["local"]["dbname"] = "bd_ferreteria";
	$config["local"]["user"] = "root";
	$config["local"]["passwd"] = "";
	//Configuracion servidor local
	$config["prod"] = array();
	$config["prod"]["host"] = "";
	$config["prod"]["dbname"] = "";
	$config["prod"]["user"] = "";
	$config["prod"]["passwd"] = "";

	writeDefaultHeaders();
	
	//Inicializar la conexión
	$con = @mysqli_connect($config[$env]["host"],$config[$env]["user"],$config[$env]["passwd"],$config[$env]["dbname"]);
	if (mysqli_connect_errno())
	{
		echoError("No se pudo conectar con la base de datos");
		exit();
	}
	mysqli_set_charset($con,"utf8");


	$postdata = file_get_contents("php://input");
	$request = json_decode($postdata);

?>