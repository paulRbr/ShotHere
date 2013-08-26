class Shothere.Models.Genre extends Backbone.RelationalModel
  urlRoot: '/genres'

  defaults:
    name: null

Shothere.Models.Genre.setup()

class Shothere.Collections.GenresCollection extends Backbone.Collection
  model: Shothere.Models.Genre

  url: (models, options) ->
    options.movie_url + "/genres"
