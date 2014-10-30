@css3factory.service "colors", ->
  nextRgbSegment = (color) ->
    if color == 0
      color++

    delta = Math.ceil(255 / color) / 10
    newColor = Math.ceil(delta * color) + color

    if newColor > 255
      255
    else
      newColor

  randomRGB = ->
    Math.floor (Math.random() *255 ) + 1

  decimalToHex = (decimal) ->
    hex = decimal.toString(16)
    if hex.length < 2
      hex = "0#{hex}"

    hex

  randomColor: ->
    r: randomRGB()
    g: randomRGB()
    b: randomRGB()

  rgbToHex: (rgb) ->
    r = decimalToHex(rgb.r)
    g = decimalToHex(rgb.g)
    b = decimalToHex(rgb.b)

    "#{r}#{g}#{b}".toUpperCase()

  nextColor: (rgb) ->
    r: nextRgbSegment(rgb.r)
    g: nextRgbSegment(rgb.g)
    b: nextRgbSegment(rgb.b)
