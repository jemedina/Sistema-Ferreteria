use bd_ferreteria;

delimiter //
drop trigger delete_producto_venta_on_delete_producto//
create trigger delete_producto_venta_on_delete_producto before delete on producto
	for each row
	begin
		set @gg = OLD.no_catalogo;
		delete from producto_venta where codigo = OLD.no_catalogo;
	end//