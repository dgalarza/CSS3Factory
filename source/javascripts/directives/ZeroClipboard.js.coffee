@css3factory.directive "zeroClipboard", ($timeout) ->
  restrict: "A"

  link: (scope, elem, attrs) ->
    getCodeSampleToCopy = ->
      copyTarget = elem.data("copy-target")
      $(copyTarget).text()

    copyCallback = ->
      elem.text("Copied!")

      $timeout ->
        elem.text("Copy")
      , 1500

    elem.zclip
      path: '/ZeroClipboard.swf'
      copy: getCodeSampleToCopy
      afterCopy: copyCallback
