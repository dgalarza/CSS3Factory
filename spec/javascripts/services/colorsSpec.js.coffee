describe "Service: colors", ->
  beforeEach module("css3factory")

  beforeEach(
    inject((colors) ->
      @colorsService = colors
    )
  )

  describe "#randomColor", ->
    it "returns a random valid rgb color", ->
      randomColor = @colorsService.randomColor()

      expect(randomColor.r).toBeGreaterThan(0)
      expect(randomColor.r).toBeLessThan(256)

      expect(randomColor.g).toBeGreaterThan(0)
      expect(randomColor.g).toBeLessThan(256)

      expect(randomColor.b).toBeGreaterThan(0)
      expect(randomColor.b).toBeLessThan(256)

  describe "#rgbToHex", ->
    it "converts a given RGB color to hex", ->
      rgb = { r: 14, g: 237, b: 174 }
      hex = @colorsService.rgbToHex(rgb)

      expect(hex).toEqual("0EEDAE")

  describe "#nextColor", ->
    it "returns a similar color to the given color", ->
      rgb = { r: 14, g: 237, b: 174 }

      nextColor = @colorsService.nextColor(rgb)
      similarColor = {
        r: 41
        g: 255
        b: 209
      }

      expect(nextColor).toEqual(similarColor)
