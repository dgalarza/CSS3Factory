describe("ColorPicker Component", function() {
  const TestUtils = React.addons.TestUtils;
  var container;

  beforeEach(function() {
    container = document.createElement("div");
  });

  describe("render", function() {
    it("initializes the ColorPicker plugin", function() {
      spyOn($.fn, "ColorPicker");

      const component = renderColorPicker({});

      expect($.fn.ColorPicker).toHaveBeenCalled();
    });
  });

  describe("color changed", function() {
    it("calls the updateColor callback", function() {
      const colorPickedSpy = jasmine.createSpy();
      const component = renderColorPicker({
        updateColor: colorPickedSpy
      });

      const node = ReactDOM.findDOMNode(component);
      $(node).find(".colorpicker_hex input").val("333333").trigger("change");

      expect(colorPickedSpy).toHaveBeenCalled();
    });
  });

  describe("setColor", function() {
    it("updates the color picker", function() {
      spyOn($.fn, "ColorPickerSetColor");
      const component = renderColorPicker({});
      const node = ReactDOM.findDOMNode(component);

      component.setColor("333333");

      expect($(node).ColorPickerSetColor).toHaveBeenCalledWith("333333");
    });
  });

  function renderColorPicker(props) {
    return ReactDOM.render(
      React.createElement(ColorPicker, props),
      container
    );
  }
});
