@css3factory.factory "swatchFactory", (colors) ->
  nextSwatchId = 0

  buildSwatch: ->
    randomRGB = colors.randomColor()
    randomHex = colors.rgbToHex(randomRGB)

    new Swatch
      id: nextSwatchId++
      hex: randomHex
      rgb: randomRGB

  generateRandomSwatches: ->
    randomSwatches = []
    for num in [1..2]
      randomSwatches.push @buildSwatch()

    randomSwatches
