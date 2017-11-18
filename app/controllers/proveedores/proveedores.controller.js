var proveedoresController = function($scope, $http) {
	
	$scope.prov = {};
	
	$scope.cargarEstados();

	$scope.provNuevo = false;

	$("#buscarProvInput").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerNombresProveedores.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarProvInput").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.nombreCompleto,'id':obj.id_prov} });
	            	response(nombresArr);
	            }
	        });
	    },
	    select: function(evt, ui) {
	    	$scope.selectedUserId = ui.item.id;
	    	//Cargar el usuario con ese ID
	    	$http({
	    		url:'api/obtenerProveedorPorId.php',
	    		data: {id:ui.item.id},
	    		method: 'POST'
	    	}).then(function ok(resp) {
	    		//Convert timestamps to date
	    		resp.data[0].f_nac = new Date(parseInt(resp.data[0].fecha_ultima_visita)*1000);

	
	    		$scope.cargarMunicipioPorCveEnt(resp.data[0].cve_ent);
	    		$scope.prov = resp.data[0];
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});

	$scope.agregar = function () {
		$scope.prov.id_prov = $scope.selectedUserId;
		var endpointUrl = "api/guardarProveedor.php";
		if($scope.selectedUserId != undefined) {
			endpointUrl = "api/actualizarProveedor.php";
		}
		$http({
			headers: { 'Content-Transfer-Encoding': 'utf-8' },
			url: endpointUrl,
			method: 'POST',
			data: $scope.prov
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			if($scope.selectedUserId == undefined) 
				$scope.prov = {};
			
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}


	$scope.alta = function() {
		$scope.provNuevo=true;
		$scope.selectedUserId = undefined;
		$scope.prov = {};
	} 

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		$scope.provNuevo=false;
		$scope.selectedUserId = undefined;
		$("#buscarProvInput").val("");
	} 

	$scope.eliminar = function($event) {
		$event.preventDefault();
		swal({
			title: 'Seguro que quieres borrar el registro?',
			text: 'Si borrar el proveedor toda su informacion se perderá',
			icon:'warning',
			buttons: ["Mmm... Mejor no!", true],}).then(
				function(result) {
					if(result) {
						$http({
							headers: { 'Content-Transfer-Encoding': 'utf-8' },
							url: 'api/eliminarProveedorPorId.php',
							method: 'POST',
							data: {id:$scope.selectedUserId}
						}).then(function ok(res) {
							swal("Registro eliminado!",
								"El registro del proveedor fue eliminado.",
								"success");
							$scope.cancelar();
						}, function err(error) {
							swal(error.data.msg, { icon: "error" } );
						});
					}
			});
			
	}
}

proveedoresController.$inject = ['$scope', '$http'];
app.controller('provedoresController', proveedoresController);
