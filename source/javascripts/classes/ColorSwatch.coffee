class CSSFactory.classes.ColorSwatch

  @pallete: null
  @colorPicker: null

  @buildSwatch: (hex, rgb, position) ->
    swatch = new ColorSwatch(hex, rgb, position)
    @addSwatch swatch.buildHTML()
    return swatch

  @addSwatch: (swatch) ->
    @pallete.find('ul').append(swatch)

  # Find the next similar color in range compared to the given RGB value
  @nextInRange: (color) ->
    color++ if color == 0

    delta = Math.ceil(255 / color) / 10
    newColor = Math.ceil(delta * color) + color
    
    return 255 if newColor > 255
    newColor

  @rgbToHex: (rgb) ->
    hex = rgb.b | (rgb.g << 8) | (rgb.r << 16)
    hex.toString(16)

  hex: null
  rgb: null
  position: null

  constructor: (@hex, @rgb, position = 0) ->
    @position = position

  setColor: (rgb, hex) ->
    @hex = hex
    @rgb = rgb

    @updateElementColor()

  activate: ->
    $('.color-swatch.active').removeClass('active')
    ColorSwatch.colorPicker.ColorPickerSetColor(@hex)
    @$el.addClass('active')

  destroy: ->
    @$el.remove()

  updateElementColor: ->
    @$el.find('.swatch').css('background-color', "##{@hex}")

  hexColorStop: ->
    "##{@hex.toUpperCase()} #{@position}%"

  rgbColorStop: ->
    "rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}) #{@position}%"

  legacyHexColorStop: ->
    position = @position / 100
    "color-stop(#{position}, ##{@hex.toUpperCase()})"

  legacyRGBColorStop: ->
    position = @position / 100
    "color-stop(#{position}, rgb(#{@rgb.r}, #{@rgb.g}, #{@rgb.b}))"

  buildHTML: ->
    swatch = @_getTemplate().clone()

    @$el = $(swatch)
    @$el.data('swatch', this)
    @updateElementColor()

    @$el

  _getTemplate: ->
    @template ||= @_cloneTemplate().removeClass('template')

