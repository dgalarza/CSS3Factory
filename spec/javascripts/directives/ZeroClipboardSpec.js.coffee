describe "Directive: ZeroClipboard", ->
  beforeEach module("css3factory")

  beforeEach ->
    inject((_$compile_, _$rootScope_) ->
      @$compile = _$compile_
      @$rootScope = _$rootScope_
    )

  it "calls zclip on the element", ->
    spyOn($.fn, "zclip")

    element = @$compile("<a zero-clipboard></a>")(@$rootScope)

    expect(element.zclip).toHaveBeenCalled()
