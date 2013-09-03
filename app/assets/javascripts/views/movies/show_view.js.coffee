Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.View
  template: JST["templates/movies/show"]

  initialize: ->
    @model.fetch()
    @listenTo @model, 'change', @render, @

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

    
