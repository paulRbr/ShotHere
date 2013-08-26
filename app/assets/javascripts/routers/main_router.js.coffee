class Shothere.Routers.MainRouter extends Marionette.AppRouter
  appRoutes:
    "index" : "index"
    "movie/:id" : "show"
    "movie/:id/update" : "update"
    "imdb/:id" : "show_imdb"
    ".*" : "index"
