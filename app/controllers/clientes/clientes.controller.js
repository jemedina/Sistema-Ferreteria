var clientesController = function($scope, $http) {
	
	$scope.client = {};
	
	$scope.cargarEstados();

	$scope.clientNuevo = false;
    
    $scope.mostrar = false; 

	$scope.mostrarDatePikerActalizarFecha = false;

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
	    	$scope.selectedUserId = ui.item.id;
	    	//Cargar el usuario con ese ID
	    	$http({
	    		url:'api/obtenerClientePorId.php',
	    		data: {id:ui.item.id},
	    		method: 'POST'
	    	}).then(function ok(resp) {
	    		//Convert timestamps to date
	    		//resp.data[0].f_nac = new Date(parseInt(resp.data[0].fecha_ultima_visita)*1000);
	    		$scope.cargarMunicipioPorCveEnt(resp.data[0].cve_ent);
	    		$scope.client = resp.data[0];
                
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});
    
$scope.agregar = function () {
		$scope.client.rfc = $scope.selectedUserId;
		var endpointUrl = "api/guardarCliente.php";
		if(!$scope.clientNuevo) {
			endpointUrl = "api/actualizarCliente.php";
		}
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
            data: $scope.client
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			if($scope.clientNuevo) //Saber si insertamos un proveedor nuevo para limpiar el form
				$scope.client = {};
			
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}

	$scope.alta = function() {
		$scope.clientNuevo=true;
		$scope.selectedUserId = undefined;
		$scope.client = {};
        $scope.mostrar=false; 
	}  
    

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		$scope.clientNuevo=false;
        $scope.mostrar=false; 
		$scope.selectedUserId = undefined;
		$("#buscarClientInput").val("");
	} 

	$scope.eliminar = function($event) {
		$event.preventDefault();
		swal({
			title: 'Seguro que quieres borrar el registro?',
			text: 'Si borras el cliente toda su informacion se perderá',
			icon:'warning',
			buttons: ["Mmm... Mejor no!", true],}).then(
				function(result) {
					if(result) {
						$http({
							headers: { 'Content-Transfer-Encoding': 'utf-8' },
							url: 'api/eliminarClientePorId.php',
							method: 'POST',
							data: {id:$scope.selectedUserId}
						}).then(function ok(res) {
							swal("Registro eliminado!",
								"El registro del cliente fue eliminado.",
								"success");
							$scope.cancelar();
						}, function err(error) {
							swal(error.data.msg, { icon: "error" } );
						});
					}
			});
			
	}
} 

clientesController.$inject = ['$scope', '$http'];
app.controller('clientesController', clientesController);
