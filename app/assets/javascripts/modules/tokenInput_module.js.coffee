TokenInputModule = (TIM, App, Backbone, Marionette, $, _) ->
  TIM.startWithParent = false;

  # Public Data
  # -------------------------
  TIM.map

  ## Definition of TokenInputModule
  TIM.addInitializer (options) ->
    $("#searchbox").tokenInput(
      "/search/movies/?format=json&imdb=1",
      propertyToSearch: "title",
      minChars: 3,
      tokenLimit: 1,
      onAdd: (item) =>
        Backbone.history.navigate "/movies/#{item.id}", true if item.id
        if item.imdb_id
          $("#overlay").show()
          model = new options.movies.model({imdb_id:item.imdb_id})
          options.movies.create(model.toJSON(),
            success: (movie) =>
              $("#overlay").hide()
              Backbone.history.navigate "/movies/#{movie.id}", true

            error: (movie, jqXHR) =>
              $("#overlay").hide()
              Backbone.history.navigate "/imdb/#{movie.get('imdb_id').match(/[0-9]+/)}", true if movie.get('imdb_id')
              console.debug $.parseJSON(jqXHR.responseText)

            wait: true
          )
      onDelete: (item) => Backbone.history.navigate "/", true
    )

  ## Subscribed events ##
  TIM.addInitializer () ->
    @listenTo Shothere.App, "app:show/index", TIM.clearInput
    @listenTo Shothere.App, 'click .token-input-token', TIM.clearInput

  TIM.clearInput = ->
    $('#searchbox').tokenInput "clear"

Shothere.App.module "TokenInputModule", TokenInputModule

Shothere.App.on "app:after:router/init", (movies) ->
  @.TokenInputModule.start {movies: movies}