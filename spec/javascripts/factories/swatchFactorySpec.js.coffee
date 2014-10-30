describe "Factory: SwatchFactory", ->
  beforeEach module("css3factory")

  beforeEach(
    inject((swatchFactory, colors) ->
      @swatchFactoryService = swatchFactory
      @colorsService = colors
    )
  )

  describe "#buildSwatch", ->
    it "returns a random swatch", ->
      randomRgb = stubRandomColor(@colorsService, r: 255, g: 255, b: 255)

      swatch = @swatchFactoryService.buildSwatch()

      expect(swatch.rgb).toEqual(randomRgb)
      expect(swatch.hex).toEqual("FFFFFF")

    it "assigns a consecutive id", ->
      swatchOne = @swatchFactoryService.buildSwatch()
      swatchTwo = @swatchFactoryService.buildSwatch()

      expect(swatchOne.id).toEqual(1)
      expect(swatchTwo.id).toEqual(2)

    describe "color provided", ->
      it "assigns the color provided", ->
        rgb = r: 255, g: 255, b: 255

        swatch = @swatchFactoryService.buildSwatch(rgb)

        expect(swatch.rgb).toEqual(rgb)

    describe "position provided", ->
      it "assigns the given position", ->
        swatch = @swatchFactoryService.buildSwatch(null, 100)

        expect(swatch.position).toEqual(100)

  describe "#randomGradientSwatches", ->
    it "returns a random base color", ->
      randomRgb = stubRandomColor(@colorsService, r: 0, g: 0, b: 0)

      randomGradientSwatches = @swatchFactoryService.randomGradientSwatches()
      baseColor = randomGradientSwatches[0]

      expect(baseColor.rgb).toEqual(randomRgb)

    it "returns a similar secondary color", ->
      similarRgb = stubSimilarColor(@colorsService, r: 255, g: 255, b: 255)

      randomGradientSwatches = @swatchFactoryService.randomGradientSwatches()
      secondaryColor = randomGradientSwatches[1]

      expect(secondaryColor.rgb).toEqual(similarRgb)

  stubRandomColor = (colorsService, rgb) ->
    spyOn(colorsService, "randomColor").and.returnValue(rgb)

    rgb

  stubSimilarColor = (colorsService, rgb) ->
    spyOn(colorsService, "nextColor").and.returnValue(rgb)

    rgb
