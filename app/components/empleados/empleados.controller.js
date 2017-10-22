
var empleadosController = function($scope, $http) {
	
	$scope.emp = {};
	
	$scope.cargarEstados($scope);

	$scope.agregar = function () {
		$http({
			url: 'api/guardarUsuario.php',
			method: 'POST',
			data: $scope.emp
		}).then(function ok(res) {
			swal(res.data.msg, { icon: "success" } );
			$scope.emp = {};
		}, function err(error) {
			swal(error.data.msg, { icon: "error" } );
		});
	}
}

empleadosController.$inject = ['$scope', '$http'];
app.controller('empleadosController', empleadosController);
