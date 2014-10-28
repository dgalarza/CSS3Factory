@css3factory.factory "gradientCodeFactory", ->
  vendorPrefixes = ['o', 'moz', 'webkit', 'ms']

  class GradientCodeGenerator
    constructor: (@swatches, position) ->
      @xStart = position.xStart
      @xEnd = position.xEnd
      @yStart = position.yStart
      @yEnd = position.yEnd
      @format = 'hex'

    generateSampleCss: ->
      prefixedGradient = @_prefixedLinearVariant()

      code = []
      for prefix in vendorPrefixes
        code.push "-#{prefix}-#{prefixedGradient}"

      code

    generateSampleCode: ->
      code = "background-image: "
      code += @_webkitLinearGradient()
      code += ";"

      gradient = @_prefixedLinearVariant()

      for prefix in vendorPrefixes
        code += "\nbackground-image: -#{prefix}-#{gradient};"

      code += "\nbackground-image: " + @_linearGradient() + ";"

    _linearGradient: ->
      str = "linear-gradient(to "

      str += @_determineDirection()
      str += ', '

      colorStopMethod = @_colorStopMethod()

      for swatch in @swatches
        str += "#{swatch[colorStopMethod]()}, "

      # Drop trailing ,
      str = str.substr(0, str.length - 2)

      str += ')'

    _prefixedLinearVariant: ->
      str = "linear-gradient("

      str += @_determineDirection()
      str += ', '

      colorStopMethod = 'hexColorStop'

      for swatch in @swatches
        str += "#{swatch[colorStopMethod]()}, "

      # Drop trailing ,
      str = str.substr(0, str.length - 2)

      str += ')'

    _determineDirection: ->
      if @xStart == @xEnd && @yStart != @yEnd
        @yEnd
      else if @yStart == @yEnd && @xStart != @xEnd
        @xEnd
      else
        "#{@xEnd} #{@yEnd}"

    # Generate the legacy webkit gradient string which is used in some older
    # webkit browers still such as some Android devices
    #
    # @example
    #   background-image: -webkit-gradient(
    #     linear,
    #     left bottom,
    #     left top,
    #     color-stop(0.18, #DE722C),
    #     color-stop(0.59, #FF9547),
    #     color-stop(0.8, #FFB364)
    #   );
    #
    _webkitLinearGradient: ->
      str = "-webkit-gradient(\n\tlinear,"
      str += "\n\t#{@xStart} #{@yStart},"
      str += "\n\t#{@xEnd} #{@yEnd},"

      colorStopMethod = @_legacyColorStopMethod()

      for swatch in @swatches
        position = swatch.position / 100
        str += "\n\t#{swatch[colorStopMethod]()},"

      str = str.substr(0, str.length - 1)
      str += "\n)"

    _legacyColorStopMethod: ->
      if @format == 'hex'
        'legacyHexColorStop'
      else
        'legacyRGBColorStop'

    _colorStopMethod: ->
      if @format == 'hex'
        'hexColorStop'
      else
        'rgbColorStop'

  generateSampleCss: (swatches, gradientDirection) ->
    generator = new GradientCodeGenerator(swatches, gradientDirection)
    generator.generateSampleCss()

  generateCodeSample: (swatches, gradientDirection) ->
    generator = new GradientCodeGenerator(swatches, gradientDirection)
    generator.generateSampleCode()
