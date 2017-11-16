
var dashboardController = function($scope) {
    $scope.saludo = "Hola soy el dashboard, quizá abrá aqui algo, quizá no, quien sabe :)";

    $scope.decirHola = function() {
        alert("Hola :)");
    }
}

dashboardController.$inject = ['$scope'];
app.controller('dashboardController', dashboardController);
