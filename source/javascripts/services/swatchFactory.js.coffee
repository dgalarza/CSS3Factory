@css3factory.factory "swatchFactory", ->
  nextSwatchId = 0

  class Swatch
    constructor: (options) ->
      @hex = options.hex.toUpperCase()
      @id = options.id
      @position = options.position

    hexColor: ->
      "##{@hex}"

    hexColorStop: ->
      "#{@hexColor()} #{@position}%"

  buildSwatch: ->
    new Swatch
      id: nextSwatchId++
      hex: "2CF246"

  generateRandomSwatches: ->
    randomSwatches = []
    for num in [1..2]
      randomSwatches.push @buildSwatch()

    randomSwatches
