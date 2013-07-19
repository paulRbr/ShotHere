# Abstract view to extend and provide
# - @mapID returning the dom id where you want to add you map (default #map)
#
class Shothere.Views.MapView extends Backbone.View
  mapID: "#map"
  
  renderMap: (lat, lon, zoom)->
    @map = L.map(@$(@mapID)[0]).setView([lat.toFixed(3), lon.toFixed(3)], zoom)
    cloudmadeUrl = 'http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg';
    subDomains = ['otile1','otile2','otile3','otile4'];
    cloudmadeAttrib = 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>, <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>';
    cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18, attribution: cloudmadeAttrib, subdomains: subDomains});
    #osm = new L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
    #  attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    #)
    cloudmade.addTo @map

  addMarker: (lat, lon) ->
    marker = L.marker([lat.toFixed(3), lon.toFixed(3)]).addTo @map
    marker

  addMarkerWithPopup: (lat, lon, template, data) ->
    @addMarker(lat, lon).bindPopup(template(data))