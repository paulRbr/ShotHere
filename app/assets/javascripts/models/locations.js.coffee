class Shothere.Models.Locations extends Backbone.Model
  paramRoot: 'location'

  defaults:
    address: null
    comment: null
    latitude: null
    longitude: null

class Shothere.Collections.LocationsCollection extends Backbone.Collection
  model: Shothere.Models.Locations
  initialize: (model, args) ->
    @url = ->
      args.movie_url + "/locations"
