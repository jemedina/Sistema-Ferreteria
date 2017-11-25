var catalogoController = function($scope, $http) {
	
	$scope.cat = {};
	
	$scope.catNuevo = false;

	$scope.cargarProveedores();

	$("#buscarCatInput").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerNombresCatalogos.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarCatInput").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.nombreCompleto,'id':obj.no_catalogo} });
	            	response(nombresArr);
	            }
	        });
	    },
	    select: function(evt, ui) {
	    	$scope.selectedUserId = ui.item.id;
	    	//Cargar el usuario con ese ID
	    	$http({
	    		url:'api/obtenerCatalogoPorNo.php',
	    		data: {id:ui.item.id},
	    		method: 'POST'
	    	}).then(function ok(resp) {
	    		//Convert timestamps to date
	    		resp.data[0].anio = new Date(parseInt(resp.data[0].anio)*1000);
	    		$scope.cargarIdProveedor(resp.data[0].id_prov);
	    		$scope.cat = resp.data[0];
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});

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


	$scope.alta = function() {
		$scope.catNuevo=true;
		$scope.selectedUserId = undefined;
		$scope.emp = {};
	} 
    

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		$scope.cat.id_prov = undefined;
		$scope.catNuevo=false;
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
							url: 'api/eliminarCatalogoPorNo.php',
							method: 'POST',
							data: {id:$scope.selectedUserId}
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
}

empleadosController.$inject = ['$scope', '$http'];
app.controller('catalogoController', catalogoController);
