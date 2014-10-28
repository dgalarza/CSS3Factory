class CSSFactory.GradientGeneratorController
  constructor: ->
    @_bindEvents()

    format = $.cookie('format')
    $('select[name=color-format]').val(format) if format
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

  colorFormatChange: (e) =>
    value = $(e.currentTarget).val()
    $.cookie('format', value, expires: 1835)
    @gradientGenerator.updateFormat(value)

  enableSliderTransitions: ->
    $('.swatch-slider').addClass('transition')

  disableSliderTransitions: ->
    $('.swatch-slider').removeClass('transition')

  _bindEvents: ->
    context = this

    $('#directions select').on 'change', @directionChange

    # Enable and disable transitions so that the slider only uses CSS3 transitions
    # when we are manually updating the value with the text field. Otherwise, the transitions
    # make the slider feel slow when they are applied and the user is dragging the slider
    # with the mouse which is unintended
    $('#color-position').on 'focus', @enableSliderTransitions
    $('#color-position').on 'blur', @disableSliderTransitions

    $('select[name=color-format]').on 'change', @colorFormatChange

    $('#code .copy-trigger').zclip
      path: '/ZeroClipboard.swf'
      copy: ->
        $('.generated-code').text()
      afterCopy: ->
        $('#code .copy-trigger').text('Copied!')
        setTimeout ->
          $('#code .copy-trigger').text('Copy')
        , 1500
