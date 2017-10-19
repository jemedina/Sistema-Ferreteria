
var empleadosController = function($scope) {
    $scope.saludo = "Hola soy el empleados controller";
}

empleadosController.$inject = ['$scope'];
app.controller('empleadosController', empleadosController);
