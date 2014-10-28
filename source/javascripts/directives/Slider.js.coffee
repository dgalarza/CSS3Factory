@css3factory.directive "slider", ->
  restrict: "E"

  template:
    """
    <div class="swatch-slider"></div>
    <input
      type="text"
      class="position-input"
      ng-model="activeSwatch.position"
      maxlength="3"
    >
    """

  controller: ($scope) ->
    $scope.positionUpdate = (e, ui) ->
      unless ui.value == Number($scope.activeSwatch.position)
        $scope.activeSwatch.position = ui.value
        $scope.$apply()

  link: ($scope, elem, attrs) ->
    elem.find(".swatch-slider").slider
      max: 100
      range: "min"
      change: $scope.positionUpdate
      slide: $scope.positionUpdate

    $scope.$watch "activeSwatch.position", (value) ->
      elem.find(".swatch-slider").slider("option", "value", value)

    elem.on "focus", ".position-input", ->
      elem.find(".swatch-slider").addClass("transition")

    elem.on "blur", ".position-input", ->
      elem.find(".swatch-slider").removeClass("transition")
