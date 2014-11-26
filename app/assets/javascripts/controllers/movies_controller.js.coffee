class Shothere.Controllers.MoviesController extends Marionette.Controller
  initialize: (options) ->
    @movies = new Shothere.Collections.MoviesCollection()
    @movies.comparator = 'box_office'
    @movies.reset options.movies if options.movies
    @count = options.movies_count if options.movies_count
    @weekNumber = options.week_number if options.week_number
    Shothere.App.trigger "app:after:router/init", @movies

  index: ->
    Shothere.App.trigger "app:show/index"

    @closeSidebar()

    @view = new Shothere.Views.Movies.IndexView(movies: @movies, count: @count, weekNumber: @weekNumber)
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

    Backbone.history.navigate "/movies/#{movie.id}", true

  show: (id) ->
    movie = @movies.get(id)
    unless movie
      movie = new Shothere.Models.Movie(id:id)
      @movies.add movie

    Shothere.App.trigger "app:show/movie", movie

    @openSidebar()

    @view = new Shothere.Views.Movies.ShowView(model: movie)
    $("#movies").html(@view.render().el)

  update: (id) ->
    movie = @movies.get(id)
    movie.save(null,
      success : (movie) =>
        Backbone.history.navigate "/movies/#{movie.id}", true
      error: (movie, jqXHR) =>
        console.warn($.parseJSON(jqXHR.responseText))
    ) if movie

  load: (movies) ->
    @movies.add movies

  openSidebar: () ->
    $("#toggleSidebar").click() unless $("#toggleSidebar").hasClass("active")
    $("#toggleSearch").click() unless $("#toggleSearch").hasClass("collapsed")
  closeSidebar: () ->
    $("#toggleSidebar").click() if $("#toggleSidebar").hasClass("active")
    $("#toggleSearch").click() if $("#toggleSearch").hasClass("collapsed")
