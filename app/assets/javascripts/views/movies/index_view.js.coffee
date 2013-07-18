Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Shothere.Views.MapView
  template: JST["templates/movies/index"]

  initialize: () ->
    @options.movies.bind('reset', @addAll)

  addAll: () =>
    @options.movies.each(@addOne)

  addOne: (movie) =>
    view = new Shothere.Views.Movies.MovieView({model : movie})
    @$("tbody").append(view.render().el)
    @addMarker movie.get("latitude"), movie.get("longitude")

  render: =>
    $(@el).html(@template(movies: @options.movies.toJSON() ))
    @renderMap @options.center[0], @options.center[1], 2
    @addAll()
    return this
