var app = angular.module('app', ['ngRoute']);

app.config(function($routeProvider) {
    $routeProvider
    .when('/empleados', {
        templateUrl: 'app/controllers/empleados/empleados.html',
        controller: 'empleadosController'
    })
     .when('/proveedores', {
        templateUrl: 'app/controllers/proveedores/proveedores.html',
        controller: 'proveedoresController'
    })
    .otherwise({
        templateUrl: 'app/controllers/dashboard/dashboard.html',
        controller: 'dashboardController'
    });
});

app.controller('mainController', ['$scope','$http', function($scope, $http) {
    $scope.nombreApp = "Sistema Ferretería";

    $scope.cargarEstados = function() {
        $http({
            method: 'GET',
            url: 'api/obtenerEstados.php'
        }).then(function ok(resp) {
            $scope.estados = resp.data;
        },function err(argument) {
            $scope.estados = {};
            $scope.errorInminente();
        });
    }

    $scope.cargarMunicipioPorCveEnt = function(cveEnt) {
        $http({
            method: 'POST',
            url: 'api/obtenerMunicipiosPorCveEnt.php',
            data: {cve_ent: cveEnt}
        }).then(function ok(resp) {
            $scope.cve_mun = undefined;
            $scope.municipios = resp.data;
        },function err(argument) {
            $scope.municipios = {};
            $scope.errorInminente();
        });
    }

    $scope.errorInminente = function(msg) {
        msg = msg || "Se produjo un error inminente! Estamos trabajando para solucionarlo...";
        swal(msg, { icon: "error" } ).then(function() {
        	window.location.pathname="Sistema-Ferreteria/login.php";
        });
        
    }
}]);
