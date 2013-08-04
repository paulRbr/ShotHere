Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.View
  template: JST["templates/movies/show"]

  initialize: ->
    @model.fetch();
    if @model.get("locations").length > 0
      router.map.setView [@model.get("locations").first().get('latitude').toFixed(3), @model.get("locations").first().get('longitude').toFixed(3)], 10
    @model.bind('change', @render, @);

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

    
