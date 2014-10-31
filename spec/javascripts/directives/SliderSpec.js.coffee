describe "Directive: Slider", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_) ->
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  beforeEach ->
    @buildActiveSwatch = buildActiveSwatch
    @compileSlider = compileSlider

  it "set's the activeSwatch's position when the slider value changes", ->
    @buildActiveSwatch position: 0
    slider = @compileSlider()

    slider.find(".swatch-slider").slider("option", "value", 100)

    expect(@$rootScope.activeSwatch.position).toEqual(100)

  it "set's the slider's value when the activeSwatch's position changes", ->
    @buildActiveSwatch position: 50
    slider = @compileSlider()

    sliderPosition = slider.find(".swatch-slider").slider("option", "value")
    expect(sliderPosition).toEqual(50)

  it "enables transitions when the user focuses the text field", ->
    slider = @compileSlider()
    appendSliderToDom slider

    $(".position-input").trigger("focus")

    expect($(".swatch-slider")).toHaveClass("transition")

  it "disables transitions after the user leaves the field", ->
    slider = @compileSlider()
    appendSliderToDom slider

    $(".position-input").trigger("focus")
    expect($(".swatch-slider")).toHaveClass("transition")

    $(".position-input").trigger("blur")
    expect($(".swatch-slider")).not.toHaveClass("transition")

  buildActiveSwatch = (activeSwatch) ->
    @$rootScope.activeSwatch = activeSwatch

  compileSlider = ->
    slider = @$compile("<slider></slider>")(@$rootScope)
    @$rootScope.$digest()
    slider

  appendSliderToDom = (slider) ->
    setFixtures(slider)
