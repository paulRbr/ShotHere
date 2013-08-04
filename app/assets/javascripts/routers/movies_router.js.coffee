class Shothere.Routers.MoviesRouter extends Shothere.Routers.AbsMapRouter
  initialize: (options) ->
    $('#movies').hover (-> $(@).fadeSlideLeft()), (-> $(@).fadeSlideRight 380)
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.reset options.movies if options.movies
    @initSearchInput()
    # Init map
    super options

  routes:
    "index"    : "index"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    @map.setView([0.0, 0.0], 2)
    @map.addLayer @allMoviesLayer unless @map.hasLayer @allMoviesLayer

    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").html(@view.render().el)

  show: (id) ->
    movie = @movies.get(id)
    unless movie
      movie = new Shothere.Models.Movie({id:id})
      @movies.add movie

    @map.removeLayer @allMoviesLayer if @map.hasLayer @allMoviesLayer
    markers = movie.markers()
    @map.addLayer markers unless @map.hasLayer markers
    @map.setView(markers.getBounds().getCenter(), 3)
    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)

  initSearchInput: =>
    $("#searchbox").tokenInput(
      "/search/movies/?format=json",
      propertyToSearch: "title",
      minChars: 3,
      tokenLimit: 1,
      onAdd: (item) =>
        $("#wait-overlay").show()
        window.location.hash = "/"+item.id if item.id
        if item.imdb_id
          model = new @movies.model({imdb_id:item.imdb_id})
          @movies.create(model.toJSON(),
              success: (movie) =>
                $("#wait-overlay").hide()
                window.location.hash = "/#{movie.id}"

              error: (movie, jqXHR) =>
                window.location.hash = "/error"
                console.log $.parseJSON(jqXHR.responseText)

              wait: true
            )
      onDelete: (item) => window.location.hash = "/"
    )
