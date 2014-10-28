class CSSFactory.classes.ColorSwatch
  @addSwatch: (swatch) ->
    @pallete.find('ul').append(swatch)

  hex: null
  rgb: null
  position: null

  rgbColorStop: ->
    "rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}) #{@position}%"

  legacyRGBColorStop: ->
    position = @position / 100
    "color-stop(#{position}, rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}))"
