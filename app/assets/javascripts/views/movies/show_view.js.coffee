Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.view
  template: JST["templates/movies/show"]

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

    
