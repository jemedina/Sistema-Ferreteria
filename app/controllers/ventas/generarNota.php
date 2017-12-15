<?php 
require("../../api/__install/fpdf.php"); 
require("../../api/config.php"); 
$con->multi_query("call ultimo_no_venta();");
$result_store = $con->store_result();
$no_venta = intval($result_store->fetch_object()->no_venta);	
$result_store->free();
mysqli_next_result($con);
$pdf = new FPDF(); 
$pdf->AddPage(); 
$sql="select a.codigo, a.marca, a.fecha, a.precio_vendido, a.cantidad, a.unidades, b.nombre from producto_venta a, producto b where a.no_venta=".$no_venta." and a.fecha=curdate() and b.codigo=a.codigo and b.marca=a.marca;"; 

$sql2="select sum(precio_vendido) from producto_venta where a.no_venta=".$no_venta." and a.fecha=curdate();"; 

$qry = $con->query($sql);

$qry2 = $con->query($sql2);
$suma=$qry2->fetch_array(MYSQLI_NUM); 
$total=$suma[0]; 

$pdf->setFont('Arial','B',16); 
$pdf->cell(50,10,"Lista de productos adquiridos: ",1,1,L); 
$pdf->cell(50,5,"\n ",1,1);
$pdf->setFont('Arial','B',10);

pdf->MultiCell(160,5,"Fecha: " .date("d") . " del " .date("m") . " de " .date("Y")); 

$texto="";
while ($obj = $qry->fetch_object()) {
$texto=$texto."Codigo: ".$obj->codigo." Marca: ".$obj->marca." Nombre: ".$obj->nombre." Cantidad".$obj->cantidad." Unidades".$obj->unidades." Precio de Venta: ".$obj->precio_venta."\n";     
}

$pdf->MultiCell(190,5,$texto);

$pdf->MultiCell(300,5,$total);

$pdf->Output(); 


?>