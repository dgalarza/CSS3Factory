window.css3factory.directive("reactColorPicker", function() {
  function link($scope, elem, attrs) {
    function updateColor(_, hex, rgb) {
      $scope.activeSwatch.hex = hex;
      $scope.activeSwatch.rgb = rgb;
      $scope.$apply();
    }

    const component = ReactDOM.render(
      React.createElement(ColorPicker, { updateColor: updateColor }),
      elem[0]
    );

    $scope.$watch("activeSwatch", function() {
      component.setColor($scope.activeSwatch.hex);
    });
  }

  return {
    restrict: "E",
    link: link
  };
});
