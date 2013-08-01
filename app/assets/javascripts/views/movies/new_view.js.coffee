Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.NewView extends Backbone.View
  template: JST["templates/movies/new"]

  events:
    "submit #new-movie": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (movie) =>
        movie.get("locations").each (location) =>
          router.addMarkerWithPopup location, JST["templates/movies/popup"](movie.toJSON())

        @model = movie
        window.location.hash = "/#{@model.id}"

      error: (movie, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})

      wait: true
    )

  render: ->
    $('#searchbox').tokenInput("clear")
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
