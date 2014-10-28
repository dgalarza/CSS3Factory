class CSSFactory.classes.GradientGenerator

  @vendorPrefixes = ['o', 'moz', 'webkit', 'ms']

  xStart: 'left'
  yStart: 'top'
  xEnd:   'left'
  yEnd:   'bottom'

  format: null

  currentSwatch: null
  swatches: []

  constructor: (@format = 'hex') ->
    @randomGradient()

    _swatch = @currentSwatch
    setTimeout( ->
      $(document).trigger('swatchActivated', _swatch)
    , 250)

  colorListener: (hsb, hex, rgb) ->
    return unless @currentSwatch
    @currentSwatch.setColor(rgb, hex)
    @updateGradient()

  updateDirection: (direction, angle, value) ->
    angle = angle.charAt(0).toUpperCase() + angle.slice(1)
    directionKey = "#{direction}#{angle}"

    this[directionKey] = value

    @updateGradient()

  updateGradient: ->
    @swatches = _.sortBy @swatches, (swatch) -> swatch.position

    @updateSample()
    @updateCode()

  updateSample: ->
    $sample = $('#gradient-sample')
    prefixedGradient = @_prefixedLinearVariant()

    for prefix in GradientGenerator.vendorPrefixes
      $sample.css backgroundImage: "-#{prefix}-#{prefixedGradient}"

    $sample.css backgroundImage: @generateGradient()

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

  generateGradient: ->
    @_linearGradient()

  nextSimilarSwatch: ->
    currentRGB = @currentSwatch.rgb

    rgb =
      r: CSSFactory.classes.ColorSwatch.nextInRange(currentRGB.r)
      g: CSSFactory.classes.ColorSwatch.nextInRange(currentRGB.g)
      b: CSSFactory.classes.ColorSwatch.nextInRange(currentRGB.b)

    hex = CSSFactory.classes.ColorSwatch.rgbToHex(rgb)

    @addSwatch(hex, rgb, 100)

  randomGradient: ->
    @randomSwatch()
    @newSwatch()

  updateFormat: (format) ->
    @format = format
    @updateGradient()

  randomSwatch: ->
    rgb =
      r: @_randomRGB()
      g: @_randomRGB()
      b: @_randomRGB()

    hex = CSSFactory.classes.ColorSwatch.rgbToHex(rgb)

    @addSwatch(hex, rgb)

  updateSwatchPosition: (position) ->
    @currentSwatch.position = position
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

  _determineDirection: ->
    if @xStart == @xEnd && @yStart != @yEnd
      @yEnd
    else if @yStart == @yEnd && @xStart != @xEnd
      @xEnd
    else
      "#{@xEnd} #{@yEnd}"

  _randomRGB: ->
    Math.floor((Math.random() *255 ) + 1)

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
