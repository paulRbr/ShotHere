MapModule = (MM, App, Backbone, Marionette, $, _, L) ->
  MM.startWithParent = false;

  # Public Data
  # -------------------------
  MM.map

  ## Definition of MapModule
  MM.addInitializer (options) ->
    L.Icon.Default.imagePath = '/assets/' # Because of strange error from Leaflet on SetView later

    cloudmadeUrl = 'http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg'
    subDomains = ['otile1','otile2','otile3','otile4']
    cloudmadeAttrib = 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>, <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>'
    cloudmade = new L.TileLayer(cloudmadeUrl, {minZoom: 6, maxZoom: 18, attribution: cloudmadeAttrib, subdomains: subDomains})

#    mapboxUrl = 'https://{s}.tiles.mapbox.com/v3/mapbox.natural-earth-2/{z}/{x}/{y}.png'
    mapboxUrl = 'https://{s}.tiles.mapbox.com/v3/popox.gobll1in/{z}/{x}/{y}.png'
#    mapboxUrl = 'http://{s}.tiles.mapbox.com/v3/mapbox.control-room/{z}/{x}/{y}.png'
    mapboxAttrib = "&copy; <a href=\"https://www.mapbox.com/\" target=\"_blank\">Mapbox</a> &copy; <a href=\"http://osm.org/copyright\" target=\"_blank\">OpenStreetMap</a> contributors"
    mapbox = new L.tileLayer(mapboxUrl, {minZoom: 0, maxZoom: 18, attribution: mapboxAttrib})

    osmUrl = "http://{s}.tile.osm.org/{z}/{x}/{y}.png"
    osmAttrib = "&copy; <a href=\"http://osm.org/copyright\" target=\"_blank\">OpenStreetMap</a> contributors"
    osm = new L.tileLayer(osmUrl, {minZoom: 0, maxZoom: 6, attribution: osmAttrib})

    defaultLayers = [mapbox]

    MM.oneMovieLayer = L.layerGroup()
    defaultLayers.push MM.oneMovieLayer

    MM.allMovieLayer = new L.MarkerClusterGroup(maxClusterRadius: 30, disableClusteringAtZoom: 10)
    defaultLayers.push MM.allMovieLayer
    if options && options.movies
      @movies = options.movies
      @movies.map (movie) -> MM.addMarkers movie

    # need a #map container at this point
    MM.map = L.map 'map', {worldCopyJump: true, layers: defaultLayers, zoomControl: false}
    # For leaflet 0.7.0
    # MM.map = L.map 'map',
    #  center: new L.LatLng 0.0, 0.0
    #  zoom: 2
    #  worldCopyJump: true
    #  layers: defaultLayers
    L.control.zoom({position: 'bottomleft'}).addTo MM.map
    MM.map.setView([0.0, 0.0], 2)

  MM.addInitializer () ->
    @listenTo Shothere.App, "app:show/index", MM.onShowIndex
    @listenTo Shothere.App, "app:show/movie", MM.onShowMovie
    @listenTo @movies, "add", MM.addMarkers if @movies

  MM.addMarkers = (movie) ->
    markers = MM.getMarkersOf movie
    MM.allMovieLayer.addLayer markers if markers

  MM.onShowIndex = ->
    MM.map.setView([0.0, 0.0], 2)
    MM.map.addLayer MM.oneMovieLayer.clearLayers()
    MM.map.addLayer MM.allMovieLayer

  MM.onShowMovie = (movie) ->
    MM.map.removeLayer MM.allMovieLayer if MM.map.hasLayer MM.allMovieLayer
    @listenTo movie, 'change', MM.updateMarkers, movie
    MM.updateMarkers(movie)

  MM.updateMarkers = (movie) ->
    MM.oneMovieLayer.clearLayers()
    markers = MM.getMarkersOf movie
    if markers
      MM.oneMovieLayer.addLayer markers
      MM.map.addLayer MM.oneMovieLayer unless MM.map.hasLayer MM.oneMovieLayer
      MM.map.setView(markers.getBounds().getCenter(), 3)

  MM.getMarkersOf = (movie) ->
    if movie.get("locations").length > 0
      markers = L.featureGroup(
        movie.get("locations").chain().map((location) ->
          m = location.markerWithPopup(JST["templates/movies/popup"](_.extend(location.toJSON(),movie.toJSON()))) if location
          m.openPopup() if m
        ).filter((m)->m).value()
      )
    markers

Shothere.App.module "MapModule", MapModule, L

Shothere.App.on "app:after:router/init", (movies) ->
  @.MapModule.start {movies: movies}
