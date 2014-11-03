describe "Swatch", ->
  describe "#hexColor", ->
    it "returns a properly formed hex color value", ->
      swatch = new Swatch(hex: "FFFFFF")

      expect(swatch.hexColor()).toEqual("#FFFFFF")

  describe "#hexColorStop", ->
    it "returns a gradient color stop for the swatch", ->
      swatch = new Swatch(hex: "FFFFFF", position: 100)

      expect(swatch.hexColorStop()).toEqual("#FFFFFF 100%")

  describe "#legacyColorStop", ->
    it "returns a legacy color stop value for the swatch", ->
      swatch = new Swatch(hex: "FFFFFF", position: 100)

      expect(swatch.legacyHexColorStop()).toEqual("color-stop(1, #FFFFFF)")

  describe "#rgbColorStop", ->
    it "returns a gradient color stop for the swatch", ->
      swatch = new Swatch(
        rgb: r: 255, g: 255, b: 255
        position: 100
      )

      expect(swatch.rgbColorStop()).toEqual("rgb(255, 255, 255) 100%")

  describe "#legacyRGBColorStop", ->
    it "returns a legacy color stop value for the swatch", ->
      swatch = new Swatch(
        rgb: r: 255, g: 255, b: 255
        position: 90
      )

      expect(swatch.legacyRGBColorStop()).
        toEqual("color-stop(0.9, rgb(255, 255, 255))")
