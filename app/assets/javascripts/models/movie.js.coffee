class Shothere.Models.Movie extends Backbone.RelationalModel
  paramRoot: 'movie'

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
    ]

class Shothere.Collections.MoviesCollection extends Backbone.Collection
  model: Shothere.Models.Movie
  url: '/movies'
