create view proveedoresporid as SELECT `id_prov`, `nombre`, `razon_social`, `telefono`, `calle`, `colonia`, `num_domicilio_ext`, `num_domicilio_int`, `cp`, `cve_mun`, `cve_ent`, `email`, `fecha_ultima_visita` FROM proveedor;