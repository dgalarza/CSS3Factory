(function(){this.css3factory.directive("zeroClipboard",function(t){return{restrict:"A",link:function(r,n){var e,i;return i=function(){var t;return t=n.data("copy-target"),$(t).text()},e=function(){return n.text("Copied!"),t(function(){return n.text("Copy")},1500)},n.zclip({path:"/ZeroClipboard.swf",copy:i,afterCopy:e})}}})}).call(this);