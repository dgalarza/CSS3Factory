describe("SwatchList", function() {
  var container;

  beforeEach(function() {
    container = document.createElement("div");
  });

  describe("render", function() {
    it("renders a swatch node for each swatch", function() {
      const swatches = [
        { hexColor: "#ffffff" },
        { hexColor: "#000000" }
      ];

      const component = ReactDOM.render(
        React.createElement(SwatchList, { swatches: swatches }),
        container
      );
      const node = ReactDOM.findDOMNode(component);

      expect($(node).find(".color-swatch").length).toBe(2);
    });
  });
});
