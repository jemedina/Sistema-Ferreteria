var devolucionesController = function($scope, $http) {
	
	$scope.dev = {};
	
	$scope.cargarEstados();

	$scope.devNueva = false;
    $scope.devSelect = false;

	$scope.puestos = [
		"ADMINISTRADOR",
		"VENDEDOR",
		"ALMACENISTA"
	];
	
	$("#buscarDevInput").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerNumeroDevoluciones.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarDevInput").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.numeroDev,'id':obj.id_empleado} });
	            	response(nombresArr);
	            }
	        });
	    },
	    select: function(evt, ui) {
	    	$scope.selectedUserId = ui.item.id;
	    	//Cargar el usuario con ese ID
	    	$http({
	    		url:'api/obtenerEmpleadoPorId.php',
	    		data: {id:ui.item.id},
	    		method: 'POST'
	    	}).then(function ok(resp) {
	    		//Convert timestamps to date
	    		resp.data[0].f_nac = new Date(parseInt(resp.data[0].f_nac)*1000);
	 	  		resp.data[0].f_ingreso = new Date(parseInt(resp.data[0].f_ingreso)*1000);
	
	    		$scope.cargarMunicipioPorCveEnt(resp.data[0].cve_ent);
	    		$scope.emp = resp.data[0];
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});
    
    $("#buscarVenta").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerVentasParaDevolucion.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarVenta").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.numeroVenta,'id':obj.id_empleado} });
	            	response(nombresArr);
	            }
	        });
	    },
	    select: function(evt, ui) {
	    	$scope.selectedUserId = ui.item.id;
	    	//Cargar el usuario con ese ID
	    	$http({
	    		url:'api/obtenerProductosParaDevolucion.php',
	    		data: {id:ui.item.id},
	    		method: 'POST'
	    	}).then(function ok(resp) {
	    		//Convert timestamps to date
	    		$scope.dev = resp.data;
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});

	$scope.agregar = function () {
		$scope.emp.id = $scope.selectedUserId;
        $scope.emp.nu; 
		$scope.emp.f_nac_timestamp = $scope.emp.f_nac.getTime() / 1000;
		$scope.emp.f_ingreso_timestamp = $scope.emp.f_ingreso.getTime() / 1000;

		var endpointUrl = "api/guardarUsuario.php";
		if($scope.selectedUserId != undefined) {
			endpointUrl = "api/actualizarUsuario.php";
		}
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
			data: $scope.emp
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			if($scope.selectedUserId == undefined) 
				$scope.emp = {};
			
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}


	$scope.alta = function() {
		$scope.devNueva=true;
		//$scope.selectedUserId = undefined;
		$scope.dev = {};
	} 
    
    $scope.buscar=function(){
        $scope.devSelect=true;
        $scope.dev={};
    }
    

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		$scope.devNueva=false;
		$scope.selectedUserId = undefined;
		$("#buscarEmpInput").val("");
	} 

	$scope.eliminar = function($event) {
		$event.preventDefault();
		swal({
			title: 'Seguro que quieres borrar el registro?',
			text: 'Si borrar el empleado toda su informacion se perderá',
			icon:'warning',
			buttons: ["Mmm... Mejor no!", true],}).then(
				function(result) {
					if(result) {
						$http({
							headers: { 'Content-Transfer-Encoding': 'utf-8' },
							url: 'api/eliminarEmpleadoPorId.php',
							method: 'POST',
							data: {id:$scope.selectedUserId}
						}).then(function ok(res) {
							swal("Registro eliminado!",
								"El registro del empleado fue eliminado.",
								"success");
							$scope.cancelar();
						}, function err(error) {
							swal(error.data.msg, { icon: "error" } );
						});
					}
			});
			
	}
}

devolucionesController.$inject = ['$scope', '$http'];
app.controller('devolucionesController', devolucionesController);
