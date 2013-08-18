class Shothere.Routers.MoviesRouter extends Backbone.Router
  initialize: (options) ->
    $('#movies').hover (-> $(@).fadeSlideLeft()), (-> $(@).fadeSlideRight 380)
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.reset options.movies if options.movies
    Shothere.App.trigger "app:after:router/init", @movies

  routes:
    "index"    : "index"
    "movie/:id"      : "show"
    "imdb/:id" : "show_imdb"
    ".*"        : "index"

  index: ->
    Shothere.App.trigger "app:show/index"

    @view = new Shothere.Views.Movies.IndexView(movies: @movies)
    $("#movies").html(@view.render().el)

  show_imdb: (id) ->
    # check frontend
    movie = @movies.find (movie)=> (movie.get('imdb_id') == id)
    unless movie
      # check backend
      $.ajax
        url: "/search/movies/?format=json&by=imdb_id&q=#{id.match(/[0-9]+/)}"
        async: false
        complete: (jqXHR) =>
          console.debug resp
          resp = $.parseJSON(jqXHR.responseText)
          item = _.first(resp)
          movie = new Shothere.Models.Movie(item)
          @movies.add movie

    window.location.hash = "/movie/#{movie.id}"

  show: (id) ->
    movie = @movies.get(id)
    unless movie
      movie = new Shothere.Models.Movie({id:id})
      @movies.add movie

    Shothere.App.trigger "app:show/movie", movie

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)
