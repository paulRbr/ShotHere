class Shothere.Models.Location extends Backbone.RelationalModel
  paramRoot: 'location'

  defaults:
    address: null
    comment: null
    latitude: null
    longitude: null

class Shothere.Collections.LocationsCollection extends Backbone.Collection
  model: Shothere.Models.Location

  url: (models, options) ->
    options.movie_url + "/locations"
