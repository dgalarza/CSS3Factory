@css3factory.factory "swatchFactory", ->
  nextSwatchId = 0

  buildSwatch = ->
    { id: nextSwatchId++, color: "#2CF246" }

  generateRandomSwatches = ->
    randomSwatches = []
    for num in [1..2]
      randomSwatches.push buildSwatch()

    randomSwatches

  buildSwatch: buildSwatch
  generateRandomSwatches: generateRandomSwatches
