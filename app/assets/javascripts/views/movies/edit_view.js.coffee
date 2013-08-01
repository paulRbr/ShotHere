Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.EditView extends Backbone.View
  template : JST["templates/movies/edit"]

  events :
    "submit #edit-movie" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (movie) =>
        @model = movie
        window.location.hash = "/#{@model.id}"
      error: (movie, jqXHR) =>
        @model = movie
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render : ->
    $('#searchbox').tokenInput "clear"
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
