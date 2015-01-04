Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Backbone.View
  template: JST["templates/movies/index"]

  render: =>
    $(@el).html(@template(movies: @options.movies.toJSON(), count: @options.count, weekNumber: @options.weekNumber ))
    return this