class CSSFactory.classes.GradientGenerator
  updateDirection: (direction, angle, value) ->
    angle = angle.charAt(0).toUpperCase() + angle.slice(1)
    directionKey = "#{direction}#{angle}"

    this[directionKey] = value

    @updateGradient()

  updateGradient: ->
    @swatches = _.sortBy @swatches, (swatch) -> swatch.position

    @updateCode()

  updateCode: ->
    code = "background-image: "
    code += @_webkitLinearGradient()
    code += ";"

    gradient = @_prefixedLinearVariant()

    for prefix in GradientGenerator.vendorPrefixes
      code += "\nbackground-image: -#{prefix}-#{gradient};"

    code += "\nbackground-image: " + @_linearGradient() + ";"
    code = "<pre>#{code}</pre>"
    $('.generated-code').html(code)

  updateFormat: (format) ->
    @format = format
    @updateGradient()

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

  # Similar to the _linearGradient method however the prefixed versions
  # do not support the *to* keyword in their location
  _prefixedLinearVariant: ->
    str = "linear-gradient("

    str += @_determineDirection()
    str += ', '

    colorStopMethod = @_colorStopMethod()

    for swatch in @swatches
      str += "#{swatch[colorStopMethod]()}, "

    # Drop trailing ,
    str = str.substr(0, str.length - 2)

    str += ')'

  _colorStopMethod: ->
    if @format == 'hex'
      'hexColorStop'
    else
      'rgbColorStop'

  _legacyColorStopMethod: ->
    if @format == 'hex'
      'legacyHexColorStop'
    else
      'legacyRGBColorStop'
