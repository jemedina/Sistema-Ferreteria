use bd_ferreteria;

delimiter //
create procedure guardar_catalogo(in _id_prov int, in _nombre varchar(100), in _anio int)
begin
	declare c int;
	set c = (SELECT count(no_catalogo) FROM catalogo WHERE id_prov = _id_prov AND anio = _anio);
	set c = c+1;
	INSERT INTO 
		catalogo
		SET 
		id_prov = _id_prov,
        nombre=_nombre,
        anio=_anio,
        no_catalogo=c;
end//

