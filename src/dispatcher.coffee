if typeof window isnt 'undefined'
  Mousetrap = require 'mousetrap'

EventEmitter = require 'wolfy-eventemitter'

class Dispatcher extends EventEmitter.EventEmitter
  construct: ->

  replaceCells: (cellsArray) ->
    @emit 'replace-cells', cellsArray

  handleCellDoubleClicked: (coord) ->
    @emit 'cell-doubleClicked', coord # coord should be an array like [rowNumber, colNumber]

  handleCellClicked: (coord) ->
    @emit 'cell-clicked', coord

  handleCellEdited: (value) ->
    @emit 'new-cell-value', value

  initKeyboardShortcuts: ->
    shortcuts =
      'down': ['down', 'enter']
      'up': 'up'
      'left': 'left'
      'right': 'right'
      'all-down': 'ctrl+down'
      'all-up': 'ctrl+up'
      'all-left': 'ctrl+left'
      'all-right': 'ctrl+right'
      'del': 'del'
      'letter': ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'w', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '=', '.', ',', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'W', 'Y', 'Z']
      'esc': 'esc'

    for eventChannel, shortcut of shortcuts
      (=>
        channel = eventChannel
        Mousetrap.bind shortcut, (e, combo) =>
          @emit channel, e, combo
      )()

dispatcher = new Dispatcher
dispatcher.initKeyboardShortcuts()

module.exports = dispatcher