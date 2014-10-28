@css3factory.factory "gradientCodeFactory", ->
  vendorPrefixes = ['o', 'moz', 'webkit', 'ms']

  class GradientCodeGenerator
    constructor: (@swatches, @position) ->

    generateSampleCss: ->
      prefixedGradient = @prefixedLinearVariant()

      code = []
      for prefix in vendorPrefixes
        code.push "-#{prefix}-#{prefixedGradient}"

      code

    prefixedLinearVariant: ->
      str = "linear-gradient("

      str += @determineDirection(@position)
      str += ', '

      colorStopMethod = 'hexColorStop'

      for swatch in @swatches
        str += "#{swatch[colorStopMethod]()}, "

      # Drop trailing ,
      str = str.substr(0, str.length - 2)

      str += ')'

    determineDirection: ->
      xStart = @position.xStart
      xEnd = @position.xEnd
      yStart = @position.yStart
      yEnd = @position.yEnd

      if xStart == xEnd && yStart != yEnd
        yEnd
      else if yStart == yEnd && xStart != xEnd
        xEnd
      else
        "#{xEnd} #{yEnd}"

  generateSampleCss: (swatches, gradientDirection) ->
    generator = new GradientCodeGenerator(swatches, gradientDirection)
    generator.generateSampleCss()
