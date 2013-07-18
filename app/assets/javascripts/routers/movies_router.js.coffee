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
    Y.one("#movies").setHTML(@view.render().el)

  index: ->
    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    Y.one("#movies").setHTML(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    Y.one("#movies").setHTML(@view.render().el)

  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    Y.one("#movies").setHTML(@view.render().el)
