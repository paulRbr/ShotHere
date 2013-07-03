Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.NewView extends Backbone.View
  template: JST["backbone/templates/movies/new"]

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
        @model = movie
        window.location.hash = "/#{@model.id}"

      error: (movie, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
