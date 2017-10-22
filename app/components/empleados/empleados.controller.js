
var empleadosController = function($scope, $http) {
	$scope.emp = {};
	$scope.cargarEstados($scope);
	$scope.agregar = function () {
		$http({
			url: 'api/guardarUsuario.php',
			method: 'POST',
			data: $scope.emp
		}).then(function ok(res) {
			alert(res.data.msg);			
		}, function err(error) {
			alert(error.data.msg);
		});
	}
}

empleadosController.$inject = ['$scope', '$http'];
app.controller('empleadosController', empleadosController);
