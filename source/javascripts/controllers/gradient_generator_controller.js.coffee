class CSSFactory.GradientGeneratorController
  constructor: ->
    @_bindEvents()

    @gradientGenerator = new CSSFactory.classes.GradientGenerator(format)

    $('select').uniform()

  updateSwatchLocation: (ui) ->
    @gradientGenerator.updateSwatchPosition(ui.value)
    @updateSliderInput(ui.value)

  directionChange: (e) =>
    $select = $(e.target)

    direction = $select.data('direction')
    angle = $select.data('angle')
    value = $select.val()

    @gradientGenerator.updateDirection(direction, angle, value)

  _bindEvents: ->
    $('#directions select').on 'change', @directionChange

    $('#code .copy-trigger').zclip
      path: '/ZeroClipboard.swf'
      copy: ->
        $('.generated-code').text()
      afterCopy: ->
        $('#code .copy-trigger').text('Copied!')
        setTimeout ->
          $('#code .copy-trigger').text('Copy')
        , 1500
