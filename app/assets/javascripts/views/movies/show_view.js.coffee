Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.ShowView extends Backbone.View
  template: JST["templates/movies/show"]

  render: ->
    Y.one(@el).setHTML(@template(@model.toJSON() ))
    return this
