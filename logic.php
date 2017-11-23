<?php
session_start();
$usuario=$_POST['username'];
$pass=$_POST['password'];
echo 'hola mundo';
echo $usuario;
if(!empty($_SESSION) and $_GET['logout']==1){
    session_destroy();
    //header("location:index.php");
}elseif(!empty($_SESSION)){
    //header("location:index.php");
}
if($usuario!=NULL and $pass!=NULL){
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
}
?>
