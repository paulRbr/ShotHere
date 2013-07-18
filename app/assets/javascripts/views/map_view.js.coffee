# Abstract view to extend and provide
# - @mapID returning the dom id where you want to add you map (default #map)
#
class Shothere.Views.MapView extends Backbone.View
  mapID: "#map"
  
  renderMap: (lat, lon, zoom)->
    @map = L.map(@$(@mapID)[0]).setView([lat.toFixed(3), lon.toFixed(3)], zoom)
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo @map

  addMarker: (lat, lon) ->
    marker = L.marker([lat.toFixed(3), lon.toFixed(3)]).addTo @map
    marker

  addMarkerWithPopup: (lat, lon, template, data) ->
    @addMarker(lat, lon).bindPopup(template(data))