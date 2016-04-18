window.css3factory.directive("gradientPreview", function(gradientCodeFactory) {
  const link = function($scope, elem, attrs) {
    function updateGradientSample() {
      const images = gradientCodeFactory.generateSampleCss(
        $scope.swatches,
        $scope.gradientDirection,
        $scope.colorFormat
      );


      images.forEach(function(image) {
        elem.css({ backgroundImage: image});
      });
    }

    $scope.$watch("swatches", updateGradientSample, true);
    $scope.$watch("gradientDirection", updateGradientSample, true);
    $scope.$watch("colorFormat", updateGradientSample, true);
  };

  return {
    restrict: "E",
    link: link,
  };
});
