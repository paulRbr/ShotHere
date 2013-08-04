class Shothere.Models.AbsMarkerModel extends Backbone.RelationalModel
  marker: ->
    m = L.marker([@.get('latitude').toFixed(3), @.get('longitude').toFixed(3)]) if @.get('latitude')
    m

  markerWithPopup: (htmlData) ->
    m = @marker()
    m.bindPopup(htmlData) if m
    m