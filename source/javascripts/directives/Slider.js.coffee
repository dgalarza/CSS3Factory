@css3factory.directive "slider", ->
  restrict: "A"

  controller: ($scope) ->
    $scope.positionUpdate = (e, ui) ->
      unless ui.value == Number($scope.activeSwatch.position)
        $scope.activeSwatch.position = ui.value
        $scope.$apply()

  link: ($scope, elem, attrs) ->
    elem.slider
      max: 100
      range: "min"
      change: $scope.positionUpdate
      slide: $scope.positionUpdate

    $scope.$watch "activeSwatch.position", (value) ->
      elem.slider("option", "value", value)
