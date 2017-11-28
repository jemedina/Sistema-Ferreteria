<?php
//include("api/config.php");
session_start();
if(!empty($_SESSION) and $_GET['logout']==1){
    session_destroy();
    header("location:index.php");
}/*elseif(empty($_SESSION)){
    session_destroy();
    header("location:index.php");
}*/
$conn=mysqli_connect("localhost","root","","bd_ferreteria");

if (mysqli_connect_errno())
	{
		echoError("No se pudo conectar con la base de datos");
		exit();
	}

$usuario=$_POST['username'];
$pass=$_POST['password'];

$resp=mysqli_query($conn,"select puesto,pass from empleado where correo='$usuario'");
$resultado=$resp->fetch_array(MYSQLI_NUM);
if($pass==$resultado[1]){
    $_SESSION['usuario']=$usuario;
	$_SESSION['puesto']=$resultado[0];
    header("location:index.php");
}else{
    session_destroy();
    header("location:index.php");
    //session_destroy();
}
//echo 'hola mundo';
//echo $usuario;

/*if($usuario!=NULL and $pass!=NULL){
	//session_start();
	$_SESSION['usuario']=$usuario;
	$_SESSION['pass']=$pass;
	echo 'exito al entrar';
    header("location:index.php");
    
}else{
	echo 'datos erroneos';
	echo '<a href=\"login.php\">regresar</a>';
    header("location:index.php");
    session_destroy();
}*/
?>
