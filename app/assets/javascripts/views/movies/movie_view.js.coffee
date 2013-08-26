Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.MovieView extends Backbone.View
  template: JST["templates/movies/movie"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
