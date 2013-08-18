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
        window.location.hash = "/movie/#{item.id}" if item.id
        if item.imdb_id
          $("#overlay").show()
          model = new options.movies.model({imdb_id:item.imdb_id})
          options.movies.create(model.toJSON(),
            success: (movie) =>
              $("#overlay").hide()
              window.location.hash = "/movie/#{movie.id}"

            error: (movie, jqXHR) =>
              $("#overlay").hide()
              window.location.hash = "/imdb/#{movie.get('imdb_id').match(/[0-9]+/)}" if movie.get('imdb_id')
              console.debug $.parseJSON(jqXHR.responseText)

            wait: true
          )
      onDelete: (item) => window.location.hash = "/"
    )

  TIM.addInitializer () ->
    Shothere.App.on "app:show/index", TIM.onShowIndex

  TIM.onShowIndex = ->
    $('#searchbox').tokenInput "clear"

Shothere.App.module "TokenInputModule", TokenInputModule

Shothere.App.on "app:after:router/init", (movies) ->
  @.TokenInputModule.start {movies: movies}