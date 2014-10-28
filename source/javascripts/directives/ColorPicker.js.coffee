@css3factory.directive "colorPicker", ->
  controller: ($scope) ->
    $scope.updateColor = (hsb, hex, rgb) ->
      $scope.activeSwatch.color = "##{hex}"
      $scope.$apply()

  restrict: "E"

  link: ($scope, elem, attrs) ->
    elem.ColorPicker
      flat: true
      onChange: $scope.updateColor

    $scope.$watch "activeSwatch", ->
      elem.ColorPickerSetColor($scope.activeSwatch.hex)
