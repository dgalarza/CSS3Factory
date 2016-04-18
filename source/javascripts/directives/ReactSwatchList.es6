window.css3factory.directive("reactSwatchList", function() {
  const link = function($scope, elem, attrs) {
    function swatchClicked(swatch) {
      $scope.activeSwatch = swatch;
      $scope.$apply();
    }

    $scope.$watch("swatches", function(newValue) {
      const props = {
        swatches: newValue,
        swatchClick: swatchClicked
      };

      ReactDOM.render(
        React.createElement(SwatchList, props),
        elem[0]
      );
    }, true);
  };

  return {
    restrict: "E",
    link: link,
  };
});
