var productosController = function($scope, $http, $routeParams) {
	$scope.modo_busqueda = true;
	$scope.modo_edicion = false;
	$scope.modo_agregacion = false;   
	$scope.setModoBusqueda = function() {
		$scope.modo_busqueda = true;
		$scope.modo_edicion = false;
		$scope.modo_agregacion = false;   	
	}	

	$scope.setModoEdicion = function() {
		$scope.modo_busqueda = false;
		$scope.modo_edicion = true;
		$scope.modo_agregacion = false;   	
	}	

	$scope.setModoAgregacion = function() {
		$scope.modo_busqueda = false;
		$scope.modo_edicion = false;
		$scope.modo_agregacion = true;   	
		
		$scope.cargarProveedores();
		//TODO: Descomentar la siguiente linea
		//$scope.prod = {};

		//TODO: Borrar la siguiente linea
		$scope.mockProducto();
	}	

	$scope.cancelar = function($event) {
		if($event)
			$event.preventDefault();
		
		$scope.prod = {};
		$scope.setModoBusqueda();
	}
	//TODO: Borrar esto despues del testing
	$scope.mockProducto = function () {
		$scope.prod = {
			codigo:Math.floor((Math.random()*1000) + 10000),
			marca:"Trupper (test)",
			nombre:"Desarmador trupper (test)",
			unidades_medicion:"n/a (test)",
			nombre_categoria:"Herramientas (test)",
			no_serie:Math.floor((Math.random()*1000000) + 1000000),
			descripcion:`Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo`,
			precio_venta: 35.4,
			no_caja:1,
			no_seccion:2,
			no_estante:3,
			no_repisa:2,
			existencia_bodega:20,
			existencia_caja:2,
			existencia_repisa:2,
			limite_inferior:10,
			limite_superior:40
		}
	}
	$scope.mockResultadosBusqueda = function () {
		$scope.busqueda = {
			resultados: [{
				codigo:Math.floor((Math.random()*1000) + 10000),
				nombre:"Desarmador trupper (test)",
				descripcion:`Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo`,
				precio_venta: 35.4,
				no_catalogo:20230,
				anio:2017,
				no_caja:1,
				no_seccion:2,
				no_estante:3,
				no_repisa:2,
				existencia: 3,
			},
			{
				codigo:Math.floor((Math.random()*1000) + 10000),
				nombre:"Prueba trupper (test)",
				descripcion:`Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo`,
				precio_venta:200,
				no_catalogo:21231,
				anio:2017,
				no_caja:2,
				no_seccion:1,
				no_estante:4,
				no_repisa:2,
				existencia: 3,
			}
			]
		}
	}

	$scope.mockResultadosBusqueda();
}

productosController.$inject = ['$scope', '$http', '$routeParams'];
app.controller('productosController', productosController);
