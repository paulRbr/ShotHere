TokenInputModule = (TIM, App, Backbone, Marionette, $, _) ->
  TIM.startWithParent = false;

  # Public Data
  TIM.search_controller = "movies"

  TIM.last_query = ""

  TIM.cache = {}

  # -------------------------
  ## Module private methods
  TIM._navigateTo = (movie) ->
    Backbone.history.navigate "/movies/#{movie.id}", true

  TIM._url = () ->
    "/search/#{TIM.search_controller}.json"

  # -------------------------
  ## Init of TokenInputModule
  TIM.addInitializer (options) ->
    search_controller = options.controller || "movies"
    input = $( "#searchbox" ).autocomplete
      minLength: 3,
      source: (request, response) ->
        term = request.term
        if TIM.search_controller == "movies" && term of TIM.cache
          response TIM.cache[term]
        else
          $("#search .loading").show()
          $.getJSON TIM._url(), {q: term}, (data) ->
            $("#search .loading").hide()
            TIM.cache[term] = data
            response data
      response: (e, results) ->
        TIM.search_controller = "movies"
        results.content.push(title: "<b>Get more results..</b>", more: true)
        TIM.last_query = $( "#searchbox" ).val()
        results
      select: (e, result) =>
        item = result.item
        if item.id && !item.url
          TIM._navigateTo(item)
        if item.url
          $("#overlay").show()
          exist = options.movies.findWhere imdb_id:item.id
          if (exist)
            $("#overlay").hide()
            TIM._navigateTo(exist)
          else
            options.movies.create imdb_id:item.id,
              success: (movie) =>
                TIM._navigateTo(movie)
              error: (movie, jqXHR) =>
                Backbone.history.navigate "/imdb/#{movie.get('imdb_id').match(/[0-9]+/)}", true if movie.get('imdb_id')
                console.debug $.parseJSON(jqXHR.responseText)
              complete: =>
                $("#overlay").hide()
              wait: true
        if item.more
          TIM.search_controller = "imdb_movies"
          setTimeout ->
            $( "#searchbox" ).autocomplete "search", TIM.last_query
          , 300
    input.data( "ui-autocomplete" )._renderItem = ( ul, item ) ->
      ul.css("z-index", 1099)
      title = item.title.replace(TIM.last_query, "<b>#{TIM.last_query}</b>")
      className = !!item.more ? "separator":""
      li = $( "<li class='#{className}'>" )
      li = li.append $( "<img src='#{item.poster}' title='#{item.title}' height='25px' width='40px' />" ) if item.poster
      if item.year
        li = li.append $( "<a>#{item.title} (#{item.year})</a>" )
      else
        li = li.append $( "<a>#{item.title}</a>" )
      li.appendTo ul

  TIM

Shothere.App.module "TokenInputModule", TokenInputModule

Shothere.App.on "app:after:router/init", (movies) ->
  @.TokenInputModule.start {movies: movies}