@css3factory.directive "gradientPreview", (gradientCodeFactory) ->
  restrict: "E"

  link: ($scope, elem, attrs) ->
    updateGradientSample = ->
      images = gradientCodeFactory.generateSampleCss(
        $scope.swatches,
        $scope.gradientDirection
      )

      for image in images
        elem.css backgroundImage: image

    $scope.$watch "swatches", updateGradientSample, true
