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
      resultsFormatter: (item) =>
        res = "<li>"
        res += "<img src='" + item.poster + "' title='" + item.title + "' height='25px' width='40px' /><div style='display: inline-block; padding-left: 10px;'>" if item.poster
        res += "<div>" + item.title + "</div></li>"
        res

      onAdd: (item) =>
        Backbone.history.navigate "/movies/#{item.id}", true if item.id
        if item.imdb_id
          $("#overlay").show()
          model = new options.movies.model({imdb_id:item.imdb_id})
          options.movies.create(model.toJSON(),
            success: (movie) =>
              Backbone.history.navigate "/movies/#{movie.id}", true
            error: (movie, jqXHR) =>
              Backbone.history.navigate "/imdb/#{movie.get('imdb_id').match(/[0-9]+/)}", true if movie.get('imdb_id')
              console.debug $.parseJSON(jqXHR.responseText)
            complete: =>
              $("#overlay").hide()
            wait: true
          )
        TIM.clearInput()
    )

  ## Subscribed events ##
  TIM.addInitializer () ->
    @listenTo Shothere.App, "app:show/index", TIM.clearInput

  TIM.clearInput = ->
    $('#searchbox').tokenInput "clear"

  TIM

Shothere.App.module "TokenInputModule", TokenInputModule

Shothere.App.on "app:after:router/init", (movies) ->
  @.TokenInputModule.start {movies: movies}