
var dashboardController = function($scope, $http) {
   

    $scope.cargar = function() {
        $http({
			url: 'api/obtenerProductosAsurtir.php',
            method: 'POST',
		}).then(function(resp) {
            $scope.surtirlista=resp.data; 
		},function(err) {
			swal(err.data.msg, { icon: "error" } );			
		})
    } 
    $scope.cargar()
}

dashboardController.$inject = ['$scope','$http'];
app.controller('dashboardController', dashboardController);
