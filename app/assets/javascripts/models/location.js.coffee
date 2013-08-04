class Shothere.Models.Location extends Shothere.Models.AbsMarkerModel
  urlRoot: '/locations'

  defaults:
    address: null
    comment: null
    latitude: null
    longitude: null

Shothere.Models.Location.setup()

class Shothere.Collections.LocationsCollection extends Backbone.Collection
  model: Shothere.Models.Location

  url: (models, options) ->
    options.movie_url + "/locations"
