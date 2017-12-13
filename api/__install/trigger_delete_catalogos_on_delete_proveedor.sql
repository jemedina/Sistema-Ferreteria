use bd_ferreteria;

delimiter //
create trigger delete_catalogos_on_delete_proveedor before delete on proveedor
	for each row
	begin
		delete from catalogo where id_prov = OLD.id_prov;
	end//