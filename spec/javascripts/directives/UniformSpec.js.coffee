describe "Directive: Uniform", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_) ->
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  it "calls uniform on the given element", ->
    spyOn($.fn, "uniform")

    element = @$compile("<select uniform></select>")(@$rootScope)

    expect(element.uniform).toHaveBeenCalled()
