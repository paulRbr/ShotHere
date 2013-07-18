Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.View
  template: JST["templates/movies/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    map = L.map(this.$('#map')[0]).setView([@model.get("latitude"), @model.get("longitude")], 12)
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
       attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo map
    marker = L.marker([@model.get("latitude"), @model.get("longitude")]).addTo(map)
    marker.bindPopup("<b>"+@model.get("title")+"</b><br>Was shot there!").openPopup()

    return this
