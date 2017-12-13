var ventasController = function($scope, $http, $routeParams) {
	$scope.modo_busqueda = true;
	$scope.modo_edicion = false;
	$scope.modo_agregacion = false; 

	$scope.onsumbit = function() {
		if($scope.modo_agregacion) {
			$scope.alta();
		} else if ($scope.modo_edicion) {
			$scope.update();
		}
	}
	
	$("#buscarClientInput").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerNombresClientes.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarClientInput").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.nombreCompleto,'id':obj.RFC} });
	            	response(nombresArr);
	            }
	        });
	    },
	    select: function(evt, ui) {
	    	$scope.venta.rfc = ui.item.id;
	    	$scope.$apply();	    	
	    }
	});
    
	
	$scope.valoresPorDefecto = function(){
		var today = new Date(), next20Days = new Date();
  		next20Days.setDate(today.getDate() + 15);
		
		$scope.venta = {
			fecha: parseInt(Date.now() / 1000),
			fecha_limite_pago: next20Days,
			id_empleado: GLOBAL_ID_EMPLEADO,
			nombre_empleado: GLOBAL_NOMBRE_EMPLEADO,
			descuento: 0,
			hora: today.getHours()+":"+today.getMinutes()+":"+today.getSeconds()
		};

	}

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
		$scope.valoresPorDefecto();
	}	

	$scope.cancelar = function($event) {
		if($event)
			$event.preventDefault();
		$scope.setModoBusqueda();
	}

	$scope.alta = function () {
		$scope.venta.fecha_limite_pago.setDate($scope.venta.fecha_limite_pago.getDate()-1);
		$scope.venta.fecha_limite_pago_timestamp = Math.floor($scope.venta.fecha_limite_pago.getTime() / 1000);
		$http({
			url:'api/guardarVenta.php',
			method:'POST',
			data: $scope.venta
		}).then(function (res) {
			if(res && res.data  && res.data.msg){
				swal(res.data.msg, { icon: "success" } );
				$scope.valoresPorDefecto();
			}
			else 
				$scope.commonError();
		},
		function (error) {
			if(error != undefined && error.data  != undefined && error.data.msg  != undefined)
				swal(error.data.msg, { icon: "error" } );
			else
				$scope.commonError();
		});
	}
	
}

ventasController.$inject = ['$scope', '$http', '$routeParams'];
app.controller('ventasController', ventasController);
