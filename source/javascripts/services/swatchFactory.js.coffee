@css3factory.factory "swatchFactory", (colors) ->
  nextSwatchId = 0

  buildSwatch: (rgb) ->
    unless rgb
      rgb = colors.randomColor()

    hex = colors.rgbToHex(rgb)

    new Swatch
      id: nextSwatchId++
      hex: hex
      rgb: rgb

  randomGradientSwatches: ->
    baseColor = colors.randomColor()
    secondaryColor = colors.nextColor baseColor

    [
      @buildSwatch baseColor
      @buildSwatch secondaryColor
    ]
