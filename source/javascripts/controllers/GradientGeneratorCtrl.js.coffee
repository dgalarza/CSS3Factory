@css3factory.controller "GradientGeneratorCtrl", ($scope) ->
  nextSwatchId = 0

  $scope.swatches = []

  $scope.activateSwatch = (swatch) ->
    $scope.activeSwatch = swatch

  $scope.removeSwatch = (swatch) ->
    index = $scope.swatches.indexOf(swatch)
    $scope.swatches.splice(index, 1)
    $scope.activeSwatch = _.last($scope.swatches)

  $scope.addSwatch = ->
    newSwatch = buildSwatch()
    $scope.swatches.push newSwatch
    $scope.activeSwatch = newSwatch

  $scope.isActiveSwatch = (swatch) =>
    swatch == $scope.activeSwatch

  buildSwatch = ->
    { id: nextSwatchId++, color: "#2CF246" }

  for num in [1..2]
    $scope.addSwatch()
