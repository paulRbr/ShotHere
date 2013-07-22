class Shothere.Routers.MoviesRouter extends Backbone.Router
  initialize: (options) ->
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.reset options.movies if options.movies
    @center = options.center if options.center

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
    @view = new Shothere.Views.Movies.IndexView(movies: @movies, center: @center)
    $("#movies").html(@view.render().el)
    @view.renderMap @center, 2
    @movies.each((movie)=> @view.addMarkerWithPopup movie.get("latitude"), movie.get("longitude"), @view.templatePopup, movie.toJSON())

  show: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)
    if movie.get('latitude')
      @view.renderMap [movie.get('latitude'), movie.get('longitude')], 10
      @view.addMarkerWithPopup movie.get("latitude"), movie.get("longitude"), @view.templatePopup, movie.toJSON()


  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    $("#movies").html(@view.render().el)
