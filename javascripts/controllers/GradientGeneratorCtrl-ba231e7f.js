(function(){this.css3factory.controller("GradientGeneratorCtrl",function(t,a){return t.gradientDirection={xStart:"left",yStart:"top",xEnd:"left",yEnd:"bottom"},t.colorFormat=$.cookie("format")||"hex",t.activateSwatch=function(a){return t.activeSwatch=a},t.removeSwatch=function(a){var c;return c=t.swatches.indexOf(a),t.swatches.splice(c,1),t.activeSwatch=_.last(t.swatches)},t.addSwatch=function(){var c;return c=a.buildSwatch(),t.swatches.push(c),t.activeSwatch=c},t.isActiveSwatch=function(a){return a===t.activeSwatch},t.$watch("colorFormat",function(t){return $.cookie("format",t,{expires:1835})}),t.swatches=a.randomGradientSwatches(),t.activateSwatch(_.last(t.swatches))})}).call(this);