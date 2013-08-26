Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.IndexView extends Backbone.View
  template: JST["templates/movies/index"]

  initialize: () ->
    @listenTo @options.movies, 'reset', @addAll
    $('#movies').hover (-> $(@).fadeSlideLeft()), (-> $(@).fadeSlideRight 380)

  addAll: () =>
    @options.movies.each(@addOne)

  addOne: (movie) =>
    view = new Shothere.Views.Movies.MovieView({model : movie})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(movies: @options.movies.toJSON() ))
    @addAll()
    return this