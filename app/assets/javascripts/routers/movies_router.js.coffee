class Shothere.Routers.MoviesRouter extends Shothere.Routers.AbsMapRouter
  initialize: (options) ->
    $("#searchbox").tokenInput(
      "http://"+document.location.host+"/search/movies.json/",
      options.tokenInput
    )
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
    $("#movies").fadeSlideLeft(380)
    $("#movies").html(@view.render().el)

  index: ->
    @map.setView([0.0, 10.0], 2)

    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").fadeSlideRight(380)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)
    movie.fetchRelated("locations") unless movie.get("locations")

    if movie.get("locations").length > 0
      @map.setView [movie.get("locations").first().get('latitude').toFixed(3), movie.get("locations").first().get('longitude').toFixed(3)], 10

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").fadeSlideLeft(380)
    $("#movies").html(@view.render().el)



  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    $("#movies").fadeSlideLeft(380)
    $("#movies").html(@view.render().el)
