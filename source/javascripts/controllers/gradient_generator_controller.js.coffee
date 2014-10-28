class CSSFactory.GradientGeneratorController
  constructor: ->
    @_bindEvents()

    format = $.cookie('format')
    $('select[name=color-format]').val(format) if format
    @gradientGenerator = new CSSFactory.classes.GradientGenerator(format)

    $('select').uniform()

  activateSwatch: (swatch) ->
    swatch.activate()
    swatch = @gradientGenerator.setCurrentSwatch(swatch)
    @swatchActivated(swatch)

  swatchActivated: (swatch) ->
    $('.swatch-slider').slider('option', 'value', swatch.position)
    @updateSliderInput(swatch.position)

  newSwatch: ->
    @gradientGenerator.newSwatch()

  colorChange: =>
    @gradientGenerator.colorListener.apply(@gradientGenerator, arguments)

  updateSwatchLocation: (ui) ->
    @gradientGenerator.updateSwatchPosition(ui.value)
    @updateSliderInput(ui.value)

  updateSliderInput: (val) ->
    $('#color-position').val(val)

  sliderInputChange: (e) =>
    value = $(e.target).val()
    return if value == $('.swatch-slider').slider('option', 'value')

    if value >= 0 && value <= 100
      $('.swatch-slider').slider('option', 'value', value)

  directionChange: (e) =>
    $select = $(e.target)

    direction = $select.data('direction')
    angle = $select.data('angle')
    value = $select.val()

    @gradientGenerator.updateDirection(direction, angle, value)

  addSwatch: =>
    @newSwatch()
    false

  swatchClick: (e) =>
    @activateSwatch $(e.currentTarget).data('swatch')
    false

  colorFormatChange: (e) =>
    value = $(e.currentTarget).val()
    $.cookie('format', value, expires: 1835)
    @gradientGenerator.updateFormat(value)

  removeSwatch: (e) =>
    e.stopPropagation()
    swatch = $(e.currentTarget).parents('.color-swatch').data('swatch')
    @gradientGenerator.removeSwatch(swatch)
    false

  enableSliderTransitions: ->
    $('.swatch-slider').addClass('transition')

  disableSliderTransitions: ->
    $('.swatch-slider').removeClass('transition')

  _bindEvents: ->

    context = this

    $('#color-picker').ColorPicker
      flat: true
      onChange: @colorChange

    $(document).on 'swatchActivated', (e, swatch) ->
      context.swatchActivated(swatch)

    $('.add-swatch-trigger').on 'click', @addSwatch
    $('#swatches-container').on 'click', '.color-swatch', @swatchClick
    $('#swatches-container').on 'click', '.remove-swatch', @removeSwatch
    $('#directions select').on 'change', @directionChange

    sliderCb = (e, ui) ->
      context.updateSwatchLocation(ui)

    $('.swatch-slider').slider
      max: 100
      range: 'min'
      change: sliderCb
      slide: sliderCb

    throttledSliderInputChange = _.throttle(@sliderInputChange, 500)
    $('#color-position').on 'keyup', throttledSliderInputChange

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


