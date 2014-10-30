@css3factory.factory "swatchFactory", (colors) ->
  nextSwatchId = 0

  buildSwatch: (rgb, position) ->
    unless rgb
      rgb = colors.randomColor()

    hex = colors.rgbToHex(rgb)

    new Swatch
      id: ++nextSwatchId
      hex: hex
      rgb: rgb
      position: position

  randomGradientSwatches: ->
    baseColor = colors.randomColor()
    secondaryColor = colors.nextColor baseColor

    [
      @buildSwatch baseColor, 0
      @buildSwatch secondaryColor, 100
    ]
