window.css3factory.directive("reactColorPicker", function() {
  function controller($scope) {
    $scope.colorPicked = function(_, hex, rgb) {
      this.activeSwatch.hex = hex;
      this.activeSwatch.rgb = rgb;
      this.$apply();
    };
  }

  function link($scope, elem, attrs) {
    const component = ReactDOM.render(
      React.createElement(ColorPicker, { updateColor: $scope.colorPicked }),
      elem[0]
    );

    $scope.$watch("activeSwatch", function() {
      component.setColor($scope.activeSwatch.hex);
    });
  }

  return {
    restrict: "E",
    link: link,
    controller: controller,
  };
});
