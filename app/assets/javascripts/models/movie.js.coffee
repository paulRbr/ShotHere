class Shothere.Models.Movie extends Backbone.RelationalModel
  urlRoot: '/movies'

  defaults:
    title: null
    imdb_id: null
    year: null
    rating: null
    poster: null

  relations: 
    [
      type: Backbone.HasMany 
      key: "locations"
      relatedModel: "Shothere.Models.Location"
      includeInJSON: true
      autoFetch: true
      collectionType: "Shothere.Collections.LocationsCollection"
      reverseRelation:
        type: Backbone.HasOne
        key: 'movie'
    ,
      type: Backbone.HasMany
      key: "directors"
      relatedModel: "Shothere.Models.Director"
      includeInJSON: true
      autoFetch: true
      collectionType: "Shothere.Collections.DirectorsCollection"
      reverseRelation:
        type: Backbone.HasOne
        key: 'shot'
    ,
      type: Backbone.HasMany
      key: "genres"
      relatedModel: "Shothere.Models.Genre"
      includeInJSON: true
      autoFetch: true
      collectionType: "Shothere.Collections.GenresCollection"
      reverseRelation:
        type: Backbone.HasOne
        key: 'movie'
    ]

Shothere.Models.Movie.setup()

class Shothere.Collections.MoviesCollection extends Backbone.Collection
  model: Shothere.Models.Movie
  url: '/movies'
