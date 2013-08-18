class Shothere.Routers.MainRouter extends Marionette.AppRouter
  appRoutes:
    "index" : "index"
    "movie/:id" : "show"
    "imdb/:id" : "show_imdb"
    ".*" : "index"
