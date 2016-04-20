describe("reactSwatchList", function() {
  const context = describe;

  var $compile, $rootScope;

  beforeEach(module("css3factory"));

  beforeEach(inject(function(_$compile_, _$rootScope_) {
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  context("swatch updated", function() {
    it("re-renders the updated swatch", function() {
      const list = compileReactSwatchList([
        { hexColor: "#FFFFFF" }
      ]);

      expect($(list).find(".color-swatch")).toHaveCss({
        "background-color": "rgb(255, 255, 255)"
      });

      $rootScope.swatches = [
        { hexColor: "#000000" }
      ];
      $rootScope.$digest();

      expect($(list).find(".color-swatch")).toHaveCss({
        "background-color": "rgb(0, 0, 0)"
      });
    });
  });

  context("swatch added", function() {
    it("renders the new swatch", function() {
      const list = compileReactSwatchList([
        { hexColor: "#FFFFFF" }
      ]);

      expect($(list).find(".color-swatch").length).toBe(1);

      $rootScope.swatches.push({ hexColor: "#000000" });
      $rootScope.$digest();

      expect($(list).find(".color-swatch").length).toBe(2);
    });
  });

  function compileReactSwatchList(swatches = []) {
    $rootScope.swatches = swatches;

    const swatchList = $compile(
      "<react-swatch-list></react-swatch-list>"
    )($rootScope);
    $rootScope.$digest();

    return swatchList;
  }
});
