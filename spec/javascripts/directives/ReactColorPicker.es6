describe("reactColorPicker", function() {
  const context = describe;
  const TestUtils = React.addons.TestUtils;

  var $compile, $rootScope;

  beforeEach(module("css3factory"));

  beforeEach(inject(function(_$compile_, _$rootScope_) {
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  it("renders a colorpicker", function() {
    const colorPicker = compileReactColorPicker();

    expect($(colorPicker)).toContainElement(".colorpicker");
  });

  context("activeSwatch is changed", function() {
    it("updates the color picker to display the color of the active swatch", function() {
      const componentSpy = jasmine.createSpyObj("colorPicker", ["setColor"]);
      spyOn(ReactDOM, "render").and.returnValue(componentSpy);

      const colorPicker = compileReactColorPicker();
      $rootScope.activeSwatch = { hex: "00FF00" };
      $rootScope.$digest();

      expect(componentSpy.setColor).toHaveBeenCalledWith("00FF00");
    });
  });

  function compileReactColorPicker(options) {
    $rootScope.$digest();

    const colorPicker = $compile(
      "<react-color-picker></react-color-picker>"
    )($rootScope);

    return colorPicker;
  }
});
