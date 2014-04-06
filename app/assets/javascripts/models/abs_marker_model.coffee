class Shothere.Models.AbsMarkerModel extends Backbone.RelationalModel
  icon: ->
    L.divIcon({className: 'movie-icon', iconSize: [5,5]});

  marker: ->
    L.marker([@.get('latitude').toFixed(3), @.get('longitude').toFixed(3)], icon: @icon()) if @.get('latitude')

  markerWithPopup: (htmlData) ->
    m = @marker()
    m.bindPopup(htmlData) if m
    m.on 'mouseover', m.openPopup.bind(m)  if m
    m