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
       attribution: "&copy; <a href=\"http://osm.org/copyright\" target=\"_blank\">OpenStreetMap</a> contributors"
    )

    @allMoviesLayer = L.layerGroup(@movies.map (movie)-> movie.markers())
    @oneMovieLayer = L.layerGroup()
    defaultLayers = [osm, @allMoviesLayer, @oneMovieLayer]
    @map = L.map 'map', {layers: defaultLayers}
    @map.setView([0.0, 0.0], 2)

    baseLayers = {"CloudMade": cloudmade, "OpenStreetMap": osm}
    overlays = {"all": defaultLayers}
    L.control.layers(baseLayers, overlays).addTo @map

  addMarker: (geoModel) =>
    m = @marker(geoModel)
    m.addTo @map if m
    m

  addMarkerWithPopup: (geoModel, htmlData) =>
    m = @markerWithPopup(geoModel, htmlData)
    m.addTo @map if m
    m