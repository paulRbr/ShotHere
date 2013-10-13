TokenInputModule = (TIM, App, Backbone, Marionette, $, _) ->
  TIM.startWithParent = false;

  # Public Data
  TIM.search_controller = "movies"

  TIM.last_query = ""

  # -------------------------
  ## Definition of TokenInputModule
  TIM.addInitializer (options) ->
    search_controller = options.controller || "movies"
    $("#searchbox").tokenInput(
      ->
        "/search/#{TIM.search_controller}/?format=json"
      propertyToSearch: "title"
      minChars: 3
      tokenLimit: 1
      resultsLimit: 10
      zindex: 1050 # To be above bootstrap's navbar
      resultsFormatter: (item) =>
        if !!item.more
          res = "<li class='separator'>"
        else
          res = "<li>"
        res += "<img src='#{item.poster}' title='#{item.title}' height='25px' width='40px' /><div style='display: inline-block; padding-left: 10px;'>" if item.poster
        if item.year
          res += "<div>#{item.title} (#{item.year})</div></li>"
        else
          res += "<div>#{item.title}</div></li>"
        res
      onResult: (results) =>
        results.push(title: "<b>Get more results..</b>", more: true)
        TIM.last_query = $("#token-input-searchbox").val()
        return results
      onAdd: (item) =>
        TIM.search_controller = "movies"
        if item.id && !item.url
          TIM.navigateTo(item)
        if item.url
          $("#overlay").show()
          exist = options.movies.findWhere imdb_id:item.id
          if (exist)
            $("#overlay").hide()
            TIM.navigateTo(exist)
          else
            $("#overlay .message").append(" Loading movie..")
            options.movies.create imdb_id:item.id,
              success: (movie) =>
                TIM.navigateTo(movie)
              error: (movie, jqXHR) =>
                Backbone.history.navigate "/imdb/#{movie.get('imdb_id').match(/[0-9]+/)}", true if movie.get('imdb_id')
                console.debug $.parseJSON(jqXHR.responseText)
              complete: =>
                $("#overlay").hide()
              wait: true
        if item.more
          TIM.search_controller = "imdb_movies"
          TIM.clearInput focus: true
          setTimeout(
            ->
              # Kind of a hack: Trigger a keyboard event to perform the search in tokenInput...
              e = $.Event 'keydown'
              e.which = 32 # SPACE
              $("#token-input-searchbox").focus().val(TIM.last_query).trigger(e).change()
            100
          )
        else
          TIM.clearInput focus: false
    )

  ## Subscribed events ##
  TIM.addInitializer () ->
    @listenTo Shothere.App, "app:show/index", TIM.clearInput

  TIM.clearInput = (options)->
    $('#searchbox').tokenInput "clear", options

  TIM.navigateTo = (movie) ->
    Backbone.history.navigate "/movies/#{movie.id}", true

  TIM

Shothere.App.module "TokenInputModule", TokenInputModule

Shothere.App.on "app:after:router/init", (movies) ->
  @.TokenInputModule.start {movies: movies}