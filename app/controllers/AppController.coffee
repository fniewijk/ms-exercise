module.exports = ($scope,productLoader)->

  $scope.data = productLoader.get().success((result) ->
    $scope.data = result.data
  )

module.exports.$inject = ['$scope','productLoader']
