describe("SwatchNode", function() {
  const TestUtils = React.addons.TestUtils;
  var container;

  beforeEach(function() {
    container = document.createElement("div");
  });

  describe("render", function() {
    it("uses the swatch's hex color", function() {
      const component = renderSwatchNode({
        swatch: { hexColor: "#333333" }
      });

      const element = ReactDOM.findDOMNode(component);
      expect($(element)).toHaveCss({ "background-color": "rgb(51, 51, 51)" });
    });

    it("applies the 'active' class when it is the active swatch", function() {
      const swatch = { hexColor: "#333333" };
      const component = renderSwatchNode({
        swatch: swatch,
        activeSwatch: swatch,
      });

      const element = ReactDOM.findDOMNode(component);
      expect($(element)).toHaveClass("active");
    });
  });

  describe("clicking swatch", function() {
    it("calls a supplied callback", function() {
      const clickSpy = jasmine.createSpy();
      const swatch = { hexColor: "#333333" };
      const component = renderSwatchNode({
        swatch: swatch,
        swatchClick: clickSpy
      });

      TestUtils.Simulate.click(ReactDOM.findDOMNode(component));

      expect(clickSpy).toHaveBeenCalledWith(swatch);
    });
  });

  function renderSwatchNode(props) {
    return ReactDOM.render(
      React.createElement(SwatchNode, props),
      container
    );
  }
});
