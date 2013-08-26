Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.View
  template: JST["templates/movies/show"]

  initialize: ->
    @model.fetch()
    @listenTo @model, 'change', @render, @
    $('#movies').fadeSlideLeft().off()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

    
