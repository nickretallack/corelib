$ ->
  ###*
  The global keydown property lets your query the status of keys.
  
  <pre>
  if keydown.left
    moveLeft()
  </pre>
  
  @name keydown
  @namespace
  ###
  window.keydown = {}

  keyName = (event) ->
    jQuery.hotkeys.specialKeys[event.which] || 
    String.fromCharCode(event.which).toLowerCase()

  $(document).bind "keydown", (event) ->
    keydown[keyName(event)] = true

  $(document).bind "keyup", (event) ->
    keydown[keyName(event)] = false

