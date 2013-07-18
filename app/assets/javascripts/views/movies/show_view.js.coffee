Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Shothere.Views.MapView
  template: JST["templates/movies/show"]

  templatePopup: JST["templates/movies/popup"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    if @model.get("latitude")
      @renderMap @model.get("latitude"), @model.get("longitude"), 13
      @addMarkerWithPopup(@model.get("latitude"), @model.get("longitude"), @templatePopup, @model.toJSON()).openPopup()
    return this

    
