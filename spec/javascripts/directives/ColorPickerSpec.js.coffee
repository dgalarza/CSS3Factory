describe "Directive: ColorPicker", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_) ->
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  it "updates the colorpicker color when activeSwatch's color changes", ->
    spyOn($.fn, "ColorPickerSetColor")
    picker = @$compile("<color-picker></color-picker>")(@$rootScope)
    @$rootScope.activeSwatch =
      hex: "FFFFFF"
      rgb: { r: 255, g: 255, b: 255 }

    @$rootScope.activeSwatch.hex = "333333"
    @$rootScope.$apply()

    expect(picker.ColorPickerSetColor).toHaveBeenCalledWith("333333")

  it "updates the scope's activeSwatch color values when a color is picked", ->
    @$rootScope.activeSwatch =
      hex: "FFFFFF"
      rgb: { r: 255, g: 255, b: 255 }

    picker = @$compile("<color-picker></color-picker>")(@$rootScope)
    setFixtures(picker)

    picker.find(".colorpicker_hex input").val("333333").trigger("change")

    expect(@$rootScope.activeSwatch.hex).toEqual("333333")
