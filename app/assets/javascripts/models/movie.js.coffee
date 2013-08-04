class Shothere.Models.Movie extends Backbone.RelationalModel
  urlRoot: '/movies'

  markers: ->
    @markersGroup = @markersGroup || L.featureGroup @.get("locations").map((location) =>
      location.markerWithPopup JST["templates/movies/popup"](@.toJSON()))

  defaults:
    title: null
    imdb_id: null

  relations: 
    [
      type: Backbone.HasMany 
      key: "locations"
      relatedModel: "Shothere.Models.Location"
      includeInJSON: true
      autoFetch: true
      collectionType: "Shothere.Collections.LocationsCollection"
      reverseRelation: {
        type: Backbone.HasOne,
        key: 'movie'
      }
    ]

Shothere.Models.Movie.setup()

class Shothere.Collections.MoviesCollection extends Backbone.Collection
  model: Shothere.Models.Movie
  url: '/movies'
