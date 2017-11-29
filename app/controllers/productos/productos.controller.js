var productosController = function($scope, $http, $routeParams) {

	$scope.editando = false;
	

	$scope.cargarCatalogoPorId = function(id) {
		$http({
			url: 'api/obtenerCatalogoPorId.php',
            method: 'POST',
            data: {id: id}
		}).then(function(resp) {
            $scope.cat = resp.data[0];
            $scope.cat.anio = parseInt($scope.cat.anio);
            $scope.cat.no_catalogo = parseInt($scope.cat.no_catalogo);
            $scope.selectedCatId = $scope.cat.id;
		},function(err) {
			swal(err.data.msg, { icon: "error" } );			
		})
    }


	$scope.agregar = function () {
		//$scope.cat.anio_timestamp = $scope.cat.anio.getYear();

		var endpointUrl = "api/guardarCatalogo.php";
		
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
			data: $scope.cat
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			$scope.cat = {};
			
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}


	$scope.actualizar = function () {
		//$scope.cat.anio_timestamp = $scope.cat.anio.getYear();

		var endpointUrl = "api/actualizarCatalogo.php";
		
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
			data: $scope.cat
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}

	$scope.ensubmit = function() {
		if($scope.editando) {
			$scope.actualizar();
		}
		else {
			$scope.agregar();
		}
	}


	$scope.alta = function() {
		$scope.catNuevo=true;
		$scope.selectedUserId = undefined;
		$scope.emp = {};
	} 
    

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		window.location.hash="#!/productos";
		
		$scope.cat.id_prov = undefined;
		$scope.catNuevo=false;
		$scope.editando = false;
	} 
	

	$scope.eliminar = function($event) {
		$event.preventDefault();
		swal({
			title: 'Seguro que quieres borrar el registro?',
			text: 'Si borrar el catalogo toda su informacion se perderá',
			icon:'warning',
			buttons: ["Mmm... Mejor no!", true],}).then(
				function(result) {
					if(result) {
						$http({
							headers: { 'Content-Transfer-Encoding': 'utf-8' },
							url: 'api/eliminarCatalogo.php',
							method: 'POST',
							data: {id:$scope.cat.id}
						}).then(function ok(res) {
							swal("Registro eliminado!",
								"El registro del catlogo fue eliminado.",
								"success");
							$scope.cancelar();
						}, function err(error) {
							swal(error.data.msg, { icon: "error" } );
						});
					}
			});
			
	}

	$scope.cargarProveedores();
	if(!$routeParams || !$routeParams.id) {
		$scope.cat = {};
		
		$scope.catNuevo = false;
	} else {
		$scope.catNuevo = false;
		$scope.editando = true;
		$scope.cargarCatalogoPorId($routeParams.id);
	}
	
}

productosController.$inject = ['$scope', '$http', '$routeParams'];
app.controller('productosController', productosController);
