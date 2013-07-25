class Shothere.Routers.AbsMapRouter extends Backbone.Router
  template: JST["templates/movies/popup"]

  initialize: (options) ->
    L.Icon.Default.imagePath = '/assets/' # Because of strange error from Leaflet on SetView later

    southWest = new L.LatLng(-90, -180)
    northEast = new L.LatLng(90, 180)
    bounds = new L.LatLngBounds(southWest, northEast);

    cloudmadeUrl = 'http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg'
    subDomains = ['otile1','otile2','otile3','otile4']
    cloudmadeAttrib = 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>, <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>'
    cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 18, attribution: cloudmadeAttrib, subdomains: subDomains})
    osm = L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
       attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    )
    baseLayers = {"CloudMade": cloudmade, "OpenStreetMap": osm}

    movies = L.layerGroup(@movies.map((movie)=> @markerWithPopup(movie, @template)).filter((movie)=> movie))
    overlayMaps = {"Movies": movies}
    
    @map = L.map('map', {maxBounds: bounds, layers: [osm, movies]})
    L.control.layers(baseLayers, overlayMaps).addTo @map

  marker: (geoModel) ->
    m = L.marker([geoModel.get('latitude').toFixed(3), geoModel.get('longitude').toFixed(3)]) if geoModel.get('latitude')
    m

  markerWithPopup: (geoModel, template) ->
    m = @marker(geoModel)
    m.bindPopup(template(geoModel.toJSON())) if m

  addMarker: (geoModel) ->
    m = @marker(geoModel)
    m.addTo @map if m

  addMarkerWithPopup: (geoModel) ->
    m = @markerWithPopup(geoModel, @template)
    m.addTo @map if m