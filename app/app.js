var app = angular.module('app', ['ngRoute']);

app.config(function($routeProvider) {
    $routeProvider
    .when('/empleados', {
        templateUrl: 'app/components/empleados/empleados.html',
        controller: 'empleadosController'
    })
    .otherwise({
        templateUrl: 'app/components/dashboard/dashboard.html',
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
            console.log($scope.estados);
        },function err(argument) {
            $scope.estados = {};
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
            console.log($scope.municipios);
        },function err(argument) {
            $scope.municipios = {};
        });
    }

}]);