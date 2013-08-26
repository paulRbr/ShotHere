$.fn.fadeSlideLeft = (speed,fn) ->
  $(@).stop().animate {right : '0px'}, speed || 400, -> $.isFunction(fn) && fn.call(@)
  @
$.fn.fadeSlideRight = (px, speed,fn) ->
  $(@).stop().animate {right : '-'+px+'px'}, speed || 400, -> $.isFunction(fn) && fn.call(@)
  @