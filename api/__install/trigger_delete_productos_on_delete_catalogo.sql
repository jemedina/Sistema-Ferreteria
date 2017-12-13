use bd_ferreteria;

delimiter //
drop trigger delete_producto_on_delete_catalogo;//
create trigger delete_producto_on_delete_catalogo before delete on catalogo
	for each row
	begin
		delete from producto where no_catalogo = OLD.no_catalogo;
	end//