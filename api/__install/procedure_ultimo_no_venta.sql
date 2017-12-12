use bd_ferreteria;

delimiter //
create procedure ultimo_no_venta ()
begin
	set @no_venta = (Select count(no_venta) as cont from venta where fecha=curdate());
	select @no_venta as no_venta;
end;//