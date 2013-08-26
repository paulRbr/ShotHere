class Shothere.Models.Director extends Shothere.Models.AbsMarkerModel
  urlRoot: '/directors'

  defaults:
    name: null

Shothere.Models.Director.setup()

class Shothere.Collections.DirectorsCollection extends Backbone.Collection
  model: Shothere.Models.Director

  url: (models, options) ->
    options.movie_url + "/directors"
