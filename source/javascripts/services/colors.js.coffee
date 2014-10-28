@css3factory.factory "colors", ->
  randomColor: ->
    r: @randomRGB()
    g: @randomRGB()
    b: @randomRGB()

  randomRGB: ->
    Math.floor (Math.random() *255 ) + 1

  rgbToHex: (rgb) ->
    hex = rgb.b | (rgb.g << 8) | (rgb.r << 16)
    hex.toString(16)
