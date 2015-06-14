Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Backbone.View
  template: JST["templates/movies/index"]

  render: =>
    $(@el).html(@template(movies: @model.movies.toJSON(), count: @model.count, weekNumber: @model.weekNumber ))
    return this
