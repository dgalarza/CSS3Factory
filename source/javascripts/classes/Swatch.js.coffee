class @Swatch
  constructor: (options) ->
    @hex = options.hex.toUpperCase()
    @id = options.id
    @position = options.position

  hexColor: ->
    "##{@hex}"

  hexColorStop: ->
    "#{@hexColor()} #{@position}%"

  legacyHexColorStop: ->
    position = @position / 100
    "color-stop(#{position}, ##{@hex.toUpperCase()})"
