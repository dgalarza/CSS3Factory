@css3factory.directive "colorPicker", ->
  restrict: "E"

  controller: ($scope) ->
    $scope.updateColor = (hsb, hex, rgb) ->
      $scope.activeSwatch.hex = hex
      $scope.activeSwatch.rgb = rgb
      $scope.$apply()

  link: (scope, elem, attrs) ->
    elem.ColorPicker
      flat: true
      onChange: scope.updateColor

    scope.$watch "activeSwatch", ->
      elem.ColorPickerSetColor(scope.activeSwatch.hex)
