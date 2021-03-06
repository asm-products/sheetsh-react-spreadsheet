require 'mousetrap'

EventEmitter = require 'wolfy-eventemitter'
if EventEmitter.EventEmitter
  EventEmitter = EventEmitter.EventEmitter

class Dispatcher extends EventEmitter
  construct: ->

  replaceCells: (cellsArray) ->
    @emit 'replace-cells', cellsArray

  handleCellDoubleClicked: (coord) ->
    @emit 'cell-doubleclicked', coord # coord should be an array like [rowNumber, colNumber]

  handleCellClicked: (coord) ->
    @emit 'cell-clicked', coord

  handleCellMouseDown: (coord) ->
    @emit 'cell-mousedown', coord

  handleMouseDownStrap: (coord) ->
    @emit 'strap-mousedown', coord

  handleCellMouseUp: (coord) ->
    @emit 'cell-mouseup', coord

  handleCellMouseEnter: (coord) ->
    @emit 'cell-mouseenter', coord

  handleCellEdited: (value) ->
    @emit 'new-cell-value', value

  handleCellInputClicked: (e) ->
    @emit 'input-clicked', e.target

  handleCellInputDoubleClicked: (e) ->
    @emit 'input-doubleclicked', e.target

  handleSelectText: (e) ->
    @emit 'input-selecttext', e.target

  handleSheetClickedOut: (e) ->
    @emit 'sheet-clicked-out', e

  handleSheetMouseUpOut: (e) ->
    @emit 'sheet-mouseup-out', e

  handleClipboardChanged: (value) ->
    @emit 'clipboardchanged', value

  initKeyboardShortcuts: ->
    keyup =
      'all-down': ['command+down', 'ctrl+down']
      'all-up': ['command+up', 'ctrl+up']
      'all-left': ['command+left', 'ctrl+left']
      'all-right': ['command+right', 'ctrl+right']
      'left-keyup': 'left'
      'right-keyup': 'right'
      'del': 'del'
      'undo': 'ctrl+z'
      'redo': 'ctrl+y'
      'esc': 'esc'
      'after-copypaste': ['ctrl', 'command'],

    for eventChannel, shortcut of keyup
      (=>
        channel = eventChannel
        Mousetrap.bind shortcut, (e, combo) =>
          @emit channel, e, combo
        , 'keyup'
      )()

    keydown =
      'down': ['down', 'enter']
      'up': 'up'
      'left': 'left'
      'right': 'right'
      'tab': 'tab'
      'select-down': 'shift+down'
      'select-up': 'shift+up'
      'select-left': 'shift+left'
      'select-right': 'shift+right'
      'select-all-down': ['ctrl+shift+down', 'command+shift+down']
      'select-all-up': ['ctrl+shift+up', 'command+shift+up']
      'select-all-left': ['ctrl+shift+left', 'command+shift+left']
      'select-all-right': ['ctrl+shift+right', 'command+shift+right']
      'before-copypaste': ['ctrl', 'command']
      'cutcopy': ['ctrl+c', 'command+c', 'ctrl+x', 'command+x']

    for eventChannel, shortcut of keydown
      (=>
        channel = eventChannel
        Mousetrap.bind shortcut, (e, combo) =>
          @emit channel, e, combo
        , 'keydown'
      )()

    keypress =
      'letter': ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'w', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '=', '.', ',', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'X', 'W', 'Y', 'Z']

    for eventChannel, shortcut of keypress
      (=>
        channel = eventChannel
        Mousetrap.bind shortcut, (e, combo) =>
          @emit channel, e, combo
        , 'keypress'
      )()

dispatcher = new Dispatcher
if typeof window isnt 'undefined'
  dispatcher.initKeyboardShortcuts()

module.exports = dispatcher
