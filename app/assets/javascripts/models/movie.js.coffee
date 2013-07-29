class Shothere.Models.Movie extends Backbone.Model
  paramRoot: 'movie'

  defaults:
    title: null
    imdb_id: null

  loadLocations: ->
    @locations = new Shothere.Collections.LocationsCollection([], {movie_url: @url()});


class Shothere.Collections.MoviesCollection extends Backbone.Collection
  model: Shothere.Models.Movie
  url: '/movies'
