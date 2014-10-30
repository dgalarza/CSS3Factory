@css3factory.directive "uniform", ->
  restrict: "A"

  link: (scope, elem, attrs) ->
    elem.uniform()
