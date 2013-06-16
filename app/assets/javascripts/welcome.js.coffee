# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  map = L.map("map").setView([48.835, 2.392], 13)
  L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
    attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
  ).addTo map
  marker = L.marker([48.835, 2.392]).addTo(map)
  marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup()