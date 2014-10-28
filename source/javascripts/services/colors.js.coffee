@css3factory.factory "colors", ->
  nextRgbSegment = (color) ->
    if color == 0
      color++

    delta = Math.ceil(255 / color) / 10
    newColor = Math.ceil(delta * color) + color

    if newColor > 255
      255
    else
      newColor

  randomColor: ->
    r: @randomRGB()
    g: @randomRGB()
    b: @randomRGB()

  randomRGB: ->
    Math.floor (Math.random() *255 ) + 1

  rgbToHex: (rgb) ->
    hex = rgb.b | (rgb.g << 8) | (rgb.r << 16)
    hex.toString(16)

  nextColor: (rgb) ->
    r: nextRgbSegment(rgb.r)
    g: nextRgbSegment(rgb.g)
    b: nextRgbSegment(rgb.b)
