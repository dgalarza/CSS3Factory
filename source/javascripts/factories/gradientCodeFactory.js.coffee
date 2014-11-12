angular.module("css3factory").factory "gradientCodeFactory", ->
  generateSampleCss: (swatches, gradientDirection, format) ->
    generator = new GradientGenerator(swatches, gradientDirection, format)
    generator.generateSampleCss()

  generateCodeSample: (swatches, gradientDirection, format) ->
    generator = new GradientGenerator(swatches, gradientDirection, format)
    generator.generateSampleCode()
