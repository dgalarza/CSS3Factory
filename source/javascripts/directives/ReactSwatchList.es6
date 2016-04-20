window.css3factory.directive("reactSwatchList", function() {
  const link = function($scope, elem, attrs) {
    function renderComponent(swatches, activeSwatch) {
      const props = {
        activeSwatch: activeSwatch,
        swatches: swatches,
        swatchClick: $scope.activateSwatch,
      };

      ReactDOM.render(
        React.createElement(SwatchList, props),
        elem[0]
      );
    }

    $scope.$watch("activeSwatch", function(newValue) {
      renderComponent($scope.swatches, newValue);
    });

    $scope.$watch("swatches", function(newValue) {
      renderComponent(newValue, $scope.activeSwatch);
    }, true);
  };

  return {
    restrict: "E",
    link: link,
  };
});
