@css3factory.directive "gradientCode", (gradientCodeFactory) ->
  restrict: "E"
  template:
    """
      <pre>{{sampleCode}}</pre>
    """

  link: ($scope, elem, attrs) ->
    updateCodeSample = ->
      $scope.sampleCode =  gradientCodeFactory.generateCodeSample(
        $scope.swatches,
        $scope.gradientDirection,
        $scope.colorFormat
      )

    $scope.$watch "swatches", updateCodeSample, true
    $scope.$watch "colorFormat", updateCodeSample, true
