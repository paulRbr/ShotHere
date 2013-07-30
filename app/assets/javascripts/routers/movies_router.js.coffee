class Shothere.Routers.MoviesRouter extends Shothere.Routers.AbsMapRouter
  initialize: (options) ->
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.reset options.movies if options.movies
    # Init map
    super options

  routes:
    "new"      : "newMovie"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newMovie: ->
    @view = new Shothere.Views.Movies.NewView(collection: @movies)
    $("#movies").html(@view.render().el)

  index: ->
    @map.setView([0.0, 10.0], 2)

    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)

    @map.setView([movie.get('latitude').toFixed(3), movie.get('longitude').toFixed(3)], 10) if movie.get('latitude')

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)


  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    $("#movies").html(@view.render().el)
