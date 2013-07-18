Shothere.Views.Movies ||= {}

class Shothere.Views.Movies.MovieView extends Backbone.View
  template: JST["templates/movies/movie"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    Y.one(@el).setHTML(@template(@model.toJSON() ))
    return this
