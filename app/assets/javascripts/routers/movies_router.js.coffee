class Shothere.Routers.MoviesRouter extends Backbone.Router
  initialize: (options) ->
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.reset options.movies if options.movies

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
    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)

  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    $("#movies").html(@view.render().el)
