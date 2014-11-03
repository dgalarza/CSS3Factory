describe "GradientGenerator", ->
  describe "generateSampleCss", ->
    it "returns an array of vendor prefixed gradients", ->
      swatch = new Swatch(hex: "FFFFFF", position: 100)
      position = xStart: "left", xEnd: "left", yStart: "top", yEnd: "bottom"
      generator = new GradientGenerator([swatch], position, "hex")

      sampleCss = generator.generateSampleCss()

      expect(sampleCss).toEqual([
        "-o-linear-gradient(bottom, #FFFFFF 100%)",
        "-moz-linear-gradient(bottom, #FFFFFF 100%)",
        "-webkit-linear-gradient(bottom, #FFFFFF 100%)",
        "-ms-linear-gradient(bottom, #FFFFFF 100%)"
      ])

    describe "different values for both x and y start and end", ->
      it "includes both directions as part of the gradient string", ->
        swatch = new Swatch(hex: "FFFFFF", position: 100)
        position = xStart: "left", xEnd: "right", yStart: "top", yEnd: "bottom"
        generator = new GradientGenerator([swatch], position, "hex")

        sampleCss = generator.generateSampleCss()

        expect(sampleCss).toEqual([
          "-o-linear-gradient(right bottom, #FFFFFF 100%)",
          "-moz-linear-gradient(right bottom, #FFFFFF 100%)",
          "-webkit-linear-gradient(right bottom, #FFFFFF 100%)",
          "-ms-linear-gradient(right bottom, #FFFFFF 100%)"
        ])

    describe "only the y direction is different", ->
      it "includes only the y end as part of the gradient", ->
        swatch = new Swatch(hex: "FFFFFF", position: 100)
        position = xStart: "left", xEnd: "right", yStart: "top", yEnd: "top"
        generator = new GradientGenerator([swatch], position, "hex")

        sampleCss = generator.generateSampleCss()

        expect(sampleCss).toEqual([
          "-o-linear-gradient(right, #FFFFFF 100%)",
          "-moz-linear-gradient(right, #FFFFFF 100%)",
          "-webkit-linear-gradient(right, #FFFFFF 100%)",
          "-ms-linear-gradient(right, #FFFFFF 100%)"
        ])

  describe "#generateSampleCode", ->
    it "returns a string formatted for the gradient sample code", ->
      swatch = new Swatch(hex: "FFFFFF", position: 100)
      position = xStart: "left", xEnd: "left", yStart: "top", yEnd: "bottom"
      generator = new GradientGenerator([swatch], position, "hex")

      sampleCode = generator.generateSampleCode()

      expectedCode = """
      background-image: -webkit-gradient(
      \tlinear,
      \tleft top,
      \tleft bottom,
      \tcolor-stop(1, #FFFFFF)
      );
      background-image: -o-linear-gradient(bottom, #FFFFFF 100%);
      background-image: -moz-linear-gradient(bottom, #FFFFFF 100%);
      background-image: -webkit-linear-gradient(bottom, #FFFFFF 100%);
      background-image: -ms-linear-gradient(bottom, #FFFFFF 100%);
      background-image: linear-gradient(to bottom, #FFFFFF 100%);
      """

      expect(sampleCode).toEqual(expectedCode)
