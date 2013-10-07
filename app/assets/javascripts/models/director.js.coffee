class Shothere.Models.Director extends Backbone.RelationalModel
  urlRoot: '/directors'

  defaults:
    name: null

Shothere.Models.Director.setup()

class Shothere.Collections.DirectorsCollection extends Backbone.Collection
  model: Shothere.Models.Director

  url: (models, options) ->
    options.movie_url + "/directors"
