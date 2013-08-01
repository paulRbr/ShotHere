# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.tokeninput
#= require twitter/bootstrap
#= require leaflet
#= require hamlcoffee
#= require backbone-rails
#= require backbone-relational
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree .

window.Shothere =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$.fn.fadeSlideLeft = (px, speed,fn) ->
  if $(@).css('right') == '-'+px+'px'
    $(@).animate {right : '+='+px}, speed || 400, -> $.isFunction(fn) && fn.call(this)
$.fn.fadeSlideRight = (px, speed,fn) ->
  if $(@).css('right') == '0px'
    $(@).animate {right : '-='+px}, speed || 400, -> $.isFunction(fn) && fn.call(this)