@css3factory.directive "gradientPreview", ->
  restrict: "E"

  link: ($scope, elem, attrs) ->
    vendorPrefixes = ['o', 'moz', 'webkit', 'ms']

    updateGradientSample = ->
      $sample = $('#gradient-sample')
      $sample.css backgroundImage: generateGradient()

    generateGradient = ->
      str = "linear-gradient("

      for swatch, index in $scope.swatches
        str += "#{swatch.hexColor()} #{swatch.position}%,"

      # Drop trailing ,
      str = str.substr(0, str.length - 1)

      str += ')'

    $scope.$watch "swatches", updateGradientSample, true
