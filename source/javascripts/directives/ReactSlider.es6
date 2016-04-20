window.css3factory.directive("reactSlider", function() {
  function link($scope, elem, attrs) {
    function positionUpdated(position) {
      $scope.activeSwatch.position = position;
      $scope.$apply();
    }

    const props = {
      positionUpdated: positionUpdated,
      currentPosition: $scope.activeSwatch.position
    };

    const component = ReactDOM.render(
      React.createElement(Slider, props),
      elem[0]
    );

    $scope.$watch("activeSwatch.position", function(value) {
      component.setPosition(value);
    });
  }

  return {
    restrict: "E",
    link: link
  };
});
