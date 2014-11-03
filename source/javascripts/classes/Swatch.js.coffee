class @Swatch
  constructor: (options) ->
    @hex = options.hex?.toUpperCase()
    @rgb = options.rgb
    @id = options.id
    @position = options.position

  hexColor: ->
    "##{@hex}"

  hexColorStop: ->
    "#{@hexColor()} #{@position}%"

  legacyHexColorStop: ->
    position = @position / 100
    "color-stop(#{position}, ##{@hex.toUpperCase()})"

  rgbColorStop: ->
    "rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}) #{@position}%"

  legacyRGBColorStop: ->
    position = @position / 100
    "color-stop(#{position}, rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}))"
