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

app.controller('mainController', ['$scope', function($scope) {
    $scope.nombreApp = "Sistema Ferretería";
}]);