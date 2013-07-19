Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Shothere.Views.MapView
  template: JST["templates/movies/index"]

  templatePopup: JST["templates/movies/popup"]

  initialize: () ->
    @options.movies.bind('reset', @addAll)

  addAll: () =>
    @options.movies.each(@addOne)

  addOne: (movie) =>
    view = new Shothere.Views.Movies.MovieView({model : movie})
    @$("tbody").append(view.render().el)
    @addMarkerWithPopup movie.get("latitude"), movie.get("longitude"), @templatePopup, movie.toJSON()

  render: =>
    $(@el).html(@template(movies: @options.movies.toJSON() ))
    @renderMap @options.center[0], @options.center[1], 2
    @addAll()
    return this
