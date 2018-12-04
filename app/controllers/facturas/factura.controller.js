var facturaController = function($scope, $http, $routeParams) {

	$scope.editando = false;
	
    $scope.facNuevo = false;
    
    $scope.fac = {}; 
    
    $scope.cargarOrdenes();
    
    $scope.cargarFacturaPorFecha = function(id1,id2,callback) {
		$http({
			url: 'api/obtenerFacturaPorFecha.php',
            method: 'POST',
            data: {fecha_factura1_timestamp: new Date(id1.getTime())/1000, 
                  fecha_factura2_timestamp: new Date(id2.getTime())/1000}
		}).then(function(resp) {
            /*$scope.fac = resp.data[0];
            $scope.fac.fecha_factura = parseInt($scope.fac.fecha_factura);
            $scope.selectedFacId = $scope.fac.no_folio; */
            $scope.facturalista = resp.data; 
            if(callback && typeof callback == 'function'){
                        callback();
                } 
            $scope.selectedFacId = $scope.fac.no_folio;
		},function(err) {
			swal(err.data.msg, { icon: "error" } );			
		})
    }
    
	$scope.alta = function() {
		$scope.facNuevo=true;
		$scope.selectedFacId = undefined;
		$scope.fac = {};
	} 
    
	$scope.agregar = function () {
		//$scope.cat.anio_timestamp = $scope.cat.anio.getYear();

		var endpointUrl = "api/guardarFactura.php";
        $scope.fac.fecha_factura_timestamp = $scope.fac.fecha_factura.getTime()/1000;
        $scope.fac.no_orden=$scope.ordeneslista.find(elem=> elem.no_orden == $scope.fac.no_orden_indice).no_orden; 
        $scope.fac.fecha_orden=$scope.ordeneslista.find(elem=> elem.no_orden == $scope.fac.no_orden_indice).fecha_orden; 
        $scope.fac.fecha_limite_pago_timestamp = $scope.fac.fecha_limite_pago.getTime()/1000;
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
			data: $scope.fac
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			$scope.fac = {};
			
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


	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		window.location.hash="#!/factura";
		
		$scope.facNuevo=false;
		$scope.editando = false;
	} 
	

	$scope.eliminar = function($event,$index) {
		$event.preventDefault();
		swal({
			title: 'Seguro que quieres borrar la factura?',
			text: 'Si al borrar la factura toda su informacion se perderá',
			icon:'warning',
			buttons: ["Mmm... Mejor no!", true],}).then(
				function(result) {
					if(result) {
						$http({
							headers: { 'Content-Transfer-Encoding': 'utf-8' },
							url: 'api/eliminarFactura.php',
							method: 'POST',
							data: $scope.facturalista[$index]						}).then(function ok(res) {
							swal("Registro eliminado!",
								"El registro de la factura fue eliminada.",
								"success");
							$scope.cancelar();
						}, function err(error) {
							swal(error.data.msg, { icon: "error" } );
						});
					}
			});
			
	}

    
    $scope.cargarFacturaPorFolio = function(id) {
		$http({
			url: 'api/obtenerFacturaPorFolio.php',
            method: 'POST',
            data: {id: id}
		}).then(function(resp) {
            $scope.fac = resp.data[0];
            $scope.fac.fecha_factura = parseInt($scope.fac.fecha_factura);
            $scope.fac.no_folio = parseInt($scope.fac.no_folio);
            $scope.selectedFacId = $scope.fac.no_folio;
		},function(err) {
			swal(err.data.msg, { icon: "error" } );			
		})
    }
    
	$scope.cargarFacturas();
	if(!$routeParams || !$routeParams.id) {
		$scope.fac = {};
				
		$scope.facNuevo = false;
	} else {
		$scope.facNuevo = false;
		$scope.editando = true;
		$scope.cargarFacturaPorFolio($routeParams.id);
	} 
    
    
	
}

facturaController.$inject = ['$scope', '$http', '$routeParams'];
app.controller('facturaController', facturaController);
