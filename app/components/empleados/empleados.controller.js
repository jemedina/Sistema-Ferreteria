
var empleadosController = function($scope, $http) {
	$scope.emp = {};
	$scope.cargarEstados($scope);
	$scope.agregar = function () {
		$http({
			url: 'api/guardarUsuario.php',
			method: 'POST',
			data: $scope.emp
		}).then(function ok(data) {
			alert(data.msg);			
		}, function err(error) {
			alert(error.msg);
		});
	}


    $scope.test = function() {
        alert(JSON.stringify($scope.emp));
    }
}

empleadosController.$inject = ['$scope', '$http'];
app.controller('empleadosController', empleadosController);
