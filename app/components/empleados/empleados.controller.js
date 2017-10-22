var empleadosController = function($scope, $http) {
	
	$scope.emp = {};
	
	$scope.cargarEstados();

	$scope.empNuevo = false;

	$("#buscarEmpInput").autocomplete({
		source: function (request, response)
	    {
	        $.ajax(
	        {
	            url: 'api/obtenerNombresEmpleados.php',
	            dataType: "json",
	            data:
	            {
	                keyword: $("#buscarEmpInput").val(),
	            },
	            success: function (data)
	            {
	                var nombresArr = data.map( (obj) =>{ return {'label':obj.nombreCompleto,'id':obj.id_empleado} });
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
	    		resp.data[0].f_nac = new Date(resp.data[0].f_nac);
	    		resp.data[0].f_nac.setDate(resp.data[0].f_nac.getDate()+1)
	    		resp.data[0].f_ingreso = new Date(resp.data[0].f_ingreso);
	    		resp.data[0].f_ingreso.setDate(resp.data[0].f_ingreso.getDate()+1)

	    		$scope.cargarMunicipioPorCveEnt(resp.data[0].cve_ent);
	    		$scope.emp = resp.data[0];
	    	},function err(error) {
	    		swal(error.data.msg, { icon: "error" } );
	    	})
	    	
	    }
	});

	$scope.agregar = function () {
		$scope.emp.id = $scope.selectedUserId;
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
		$scope.empNuevo=true;
		$scope.selectedUserId = undefined;
		$scope.emp = {};
	} 

	$scope.cancelar = function($event) 
	{ 	
		if($event)
			$event.preventDefault();
		$scope.empNuevo=false;
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

empleadosController.$inject = ['$scope', '$http'];
app.controller('empleadosController', empleadosController);
