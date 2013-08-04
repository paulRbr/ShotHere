class Shothere.Routers.MoviesRouter extends Shothere.Routers.AbsMapRouter
  initialize: (options) ->
    $("#searchbox").tokenInput(
      "http://"+document.location.host+"/search/movies/?format=json",
      propertyToSearch: "title",
      minChars: 3,
      tokenLimit: 1,
      onAdd: (item) => window.location.hash = "/"+item.id
      onDelete: (item) => window.location.hash = "/"
    )
    $('#movies').hover(
      -> $(@).fadeSlideLeft(),
      -> $(@).fadeSlideRight(380)
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
    $("#movies").html(@view.render().el)

  index: ->
    @map.setView([0.0, 10.0], 2)

    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)
    unless movie
      movie = new Shothere.Models.Movie({id:id})
      @movies.add movie

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)



  edit: (id) ->
    movie = @movies.get(id)

    @view = new Shothere.Views.Movies.EditView(model: movie)
    $("#movies").html(@view.render().el)
