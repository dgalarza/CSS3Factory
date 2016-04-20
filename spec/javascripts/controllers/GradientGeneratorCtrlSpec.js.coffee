describe "Controller: GradientGeneratorCtrl", ->
  beforeEach module("css3factory")

  it "sets the default gradient direction", ->
    setupController()

    defaultDirections =
      xStart: "left"
      yStart: "top"
      xEnd: "left"
      yEnd: "bottom"

    expect(@scope.gradientDirection).toEqual(defaultDirections)

  it "sets up a random set of color swatches", ->
    randomSwatches = ["swatchOne", "swatchTwo"]

    setupController(
      mockSwatchFactory:
        randomGradientSwatches: -> randomSwatches
    )

    expect(@scope.swatches).toEqual(randomSwatches)

  it "sets the last swatch generated as the active swatch", ->
    randomSwatches = ["swatchOne", "swatchTwo"]

    setupController(
      mockSwatchFactory:
        randomGradientSwatches: -> randomSwatches
    )

    expect(@scope.activeSwatch).toEqual("swatchTwo")

  describe "watch for colorFormat change", ->
    beforeEach -> setupController()

    it "stores the new colorFormat in the user's cookie", ->
      spyOn($, "cookie")

      @scope.colorFormat = "rgb"
      @scope.$apply()

      expect($.cookie).toHaveBeenCalledWith("format", "rgb", expires: 1835)

  describe "$scope.colorFormat", ->
    it "defaults the colorFormat to hex", ->
      setupController()

      expect(@scope.colorFormat).toEqual("hex")

    it "uses the format stored in the user's cookie if available", ->
      spyOn($, "cookie").and.returnValue("rgb")

      setupController()

      expect(@scope.colorFormat).toEqual("rgb")

  describe "$scope.activateSwatch", ->
    beforeEach -> setupController()

    it "makes the given swatch the activeSwatch", ->
      swatch = { id: "active" }
      @scope.activeSwatch = { id: "some-other-swatch" }

      @scope.activateSwatch(swatch)

      expect(@scope.activeSwatch).toEqual(swatch)

  describe "$scope.removeSwatch", ->
    beforeEach -> setupController()

    it "removes the given swatch form the scope's swatches collection", ->
      removeMe = { id: "remove-me" }
      otherSwatch = { id: "other-swatch" }
      @scope.swatches = [removeMe, otherSwatch]

      @scope.removeSwatch(removeMe)

      expect(@scope.swatches).toEqual([otherSwatch])

    it "marks the last swatch available as active", ->
      removeMe = { id: "remove-me" }
      otherSwatch = { id: "other-swatch" }
      @scope.swatches = [removeMe, otherSwatch]

      @scope.removeSwatch(removeMe)

      expect(@scope.activeSwatch).toEqual(otherSwatch)

  describe "$scope.addSwatch", ->
    it "adds a new swatch built by the swatchFactory", ->
      setupController(
        mockSwatchFactory: buildSwatch: -> "builtSwatch"
      )

      @scope.addSwatch()

      expect(@scope.swatches).toEqual(["builtSwatch"])

    it "sets the newly created swatch as active", ->
      setupController(
        mockSwatchFactory: buildSwatch: -> "builtSwatch"
      )

      @scope.addSwatch()

      expect(@scope.activeSwatch).toEqual("builtSwatch")

  setupController = (options = {}) ->
    mockFactoryOptions = options.mockSwatchFactory || {}

    mockSwatchFactory = _.extend(
      defaultMockSwatchFactory(),
      mockFactoryOptions
    )

    inject(($controller, $rootScope) ->
      @scope = $rootScope.$new()
      @controller = $controller(
        "GradientGeneratorCtrl"
        $scope: @scope
        swatchFactory: mockSwatchFactory
      )
    )

  defaultMockSwatchFactory = ->
    randomGradientSwatches: -> []
