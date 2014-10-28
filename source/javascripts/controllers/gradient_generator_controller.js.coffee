class CSSFactory.GradientGeneratorController
  constructor: ->
    @_bindEvents()

  _bindEvents: ->
    $('#code .copy-trigger').zclip
      path: '/ZeroClipboard.swf'
      copy: ->
        $('.generated-code').text()
      afterCopy: ->
        $('#code .copy-trigger').text('Copied!')
        setTimeout ->
          $('#code .copy-trigger').text('Copy')
        , 1500
