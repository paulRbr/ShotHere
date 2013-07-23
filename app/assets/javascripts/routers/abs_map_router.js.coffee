class Shothere.Routers.AbsMapRouter extends Backbone.Router
  initialize: (options) ->
    @center = options.center if options.center
    @map = L.map('map').setView([@center[0].toFixed(3), @center[1].toFixed(3)], 3)
    cloudmadeUrl = 'http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg';
    subDomains = ['otile1','otile2','otile3','otile4'];
    cloudmadeAttrib = 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>, <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>';
    cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18, attribution: cloudmadeAttrib, subdomains: subDomains});
    cloudmade.addTo @map
    @movies.each((movie)=> @addMarkerWithPopup movie)

  addMarker: (geoModel) ->
    marker = L.marker([geoModel.get('latitude').toFixed(3), geoModel.get('longitude').toFixed(3)]).addTo @map
    marker

  addMarkerWithPopup: (geoModel) ->
    template = JST["templates/movies/popup"]
    @addMarker(geoModel).bindPopup(template(geoModel.toJSON()))