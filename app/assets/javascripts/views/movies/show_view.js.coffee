Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Shothere.Views.MapView
  template: JST["templates/movies/show"]

  templatePopup: JST["templates/movies/popup"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

    
