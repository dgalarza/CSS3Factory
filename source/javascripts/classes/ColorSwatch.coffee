class CSSFactory.classes.ColorSwatch
  @addSwatch: (swatch) ->
    @pallete.find('ul').append(swatch)

  hex: null
  rgb: null
  position: null

