Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Backbone.View
  template: JST["templates/movies/index"]

  initialize: () ->
    @options.movies.bind('reset', @addAll)

  addAll: () =>
    @options.movies.each(@addOne)

  addOne: (movie) =>
    view = new Shothere.Views.Movies.MovieView({model : movie})
    @Y.one("tbody").append(view.render().el)

  render: =>
    Y.one(@el).setHTML(@template(movies: @options.movies.toJSON() ))
    @addAll()

    return this
