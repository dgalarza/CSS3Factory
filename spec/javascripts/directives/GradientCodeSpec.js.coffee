describe "Directive: GradientCode", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_, gradientCodeFactory) ->
      @gradientCodeFactory = gradientCodeFactory
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  beforeEach ->
    @compileGradientSample = compileGradientSample
    @stubGradientSample = stubGradientSample

  beforeEach ->
    @stubGradientSample "foo"

  describe "Swatches are changed", ->
    it "updates the code sample", ->
      sample = @compileGradientSample()
      @stubGradientSample "bar"

      @$rootScope.swatches = [{}]
      @$rootScope.$apply()

      expect(sample.find("pre")).toHaveText("bar")

  describe "gradientDirection is updated", ->
    it "updates the code sample", ->
      sample = @compileGradientSample()
      @stubGradientSample "bar"

      @$rootScope.gradientDirection = xStart: "left"
      @$rootScope.$apply()

      expect(sample.find("pre")).toHaveText("bar")

  describe "colorFormat is updated", ->
    it "updates the code sample", ->
      sample = @compileGradientSample()
      @stubGradientSample "bar"

      @$rootScope.colorFormat = "rgb"
      @$rootScope.$apply()

      expect(sample.find("pre")).toHaveText("bar")

  compileGradientSample = ->
    sample = @$compile("<gradient-code></gradient-code>")(@$rootScope)
    @$rootScope.$digest()
    sample

  stubGradientSample = (value) ->
    unless @gradientCodeFactorySpy
      @gradientCodeFactorySpy = spyOn(
        @gradientCodeFactory,
        "generateCodeSample"
      )

    @gradientCodeFactorySpy.and.returnValue(value)
