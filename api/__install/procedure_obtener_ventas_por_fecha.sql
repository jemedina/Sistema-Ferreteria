delimiter //
create procedure obtener_ventas_por_fecha(in f DATE)
	begin
		SELECT venta.*,empleado.nombre FROM venta,empleado WHERE venta.id_empleado = empleado.id_empleado and venta.fecha = f;
	end//

