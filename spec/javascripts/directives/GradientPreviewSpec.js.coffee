describe "Directive: GradientPreview", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_, gradientCodeFactory) ->
      @gradientCodeFactory = gradientCodeFactory
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  beforeEach ->
    @stubGradientSampleCss = stubGradientSampleCss
    @compileGradientPreview = compileGradientPreview

  beforeEach ->
    @stubGradientSampleCss "#000000"

  describe "Swatches are changed", ->
    it "re-applies gradient sample css to the element", ->
      preview = @compileGradientPreview()
      spyOn($.fn, "css")

      @stubGradientSampleCss "#FFFFFF", "#333333"
      @$rootScope.swatches = [{}]
      @$rootScope.$apply()

      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#FFFFFF")
      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#333333")

  describe "gradientDirection changes", ->
    it "re-applies gradient sample css to the element", ->
      preview = @compileGradientPreview()
      spyOn($.fn, "css")

      @stubGradientSampleCss "#FFFFFF", "#333333"
      @$rootScope.gradientDirection = xStart: "left"
      @$rootScope.$apply()

      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#FFFFFF")
      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#333333")

  describe "colorFormat changes", ->
    it "re-applies gradient sample css to the element", ->
      preview = @compileGradientPreview()
      spyOn($.fn, "css")

      @stubGradientSampleCss "#FFFFFF", "#333333"
      @$rootScope.colorFormat = "rgb"
      @$rootScope.$apply()

      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#FFFFFF")
      expect(preview.css).toHaveBeenCalledWith(backgroundImage: "#333333")

  stubGradientSampleCss = (colors...) ->
    unless @gradientCodeFactorySpy
      @gradientCodeFactorySpy = spyOn(@gradientCodeFactory, "generateSampleCss")

    @gradientCodeFactorySpy.and.returnValue(colors)

  compileGradientPreview = ->
    preview = @$compile("<gradient-preview></gradient-preview>")(@$rootScope)
    @$rootScope.$digest()
    preview
