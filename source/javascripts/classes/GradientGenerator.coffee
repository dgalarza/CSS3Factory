class CSSFactory.classes.GradientGenerator
  updateDirection: (direction, angle, value) ->
    angle = angle.charAt(0).toUpperCase() + angle.slice(1)
    directionKey = "#{direction}#{angle}"

    this[directionKey] = value

    @updateGradient()

  updateFormat: (format) ->
    @format = format
    @updateGradient()

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
