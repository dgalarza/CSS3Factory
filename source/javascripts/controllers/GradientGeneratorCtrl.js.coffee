@css3factory.controller "GradientGeneratorCtrl", ($scope, swatchFactory) ->
  $scope.activateSwatch = (swatch) ->
    $scope.activeSwatch = swatch

  $scope.removeSwatch = (swatch) ->
    index = $scope.swatches.indexOf(swatch)
    $scope.swatches.splice(index, 1)
    $scope.activeSwatch = _.last($scope.swatches)

  $scope.addSwatch = ->
    newSwatch = swatchFactory.buildSwatch()
    $scope.swatches.push newSwatch
    $scope.activeSwatch = newSwatch

  $scope.isActiveSwatch = (swatch) =>
    swatch == $scope.activeSwatch

  $scope.swatches = swatchFactory.generateRandomSwatches()
  $scope.activateSwatch _.last $scope.swatches
