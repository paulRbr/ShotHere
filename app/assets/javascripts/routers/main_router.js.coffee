class Shothere.Routers.MainRouter extends Marionette.AppRouter
  appRoutes:
    "index" : "index"
    "movies/:id" : "show"
    "movies/:id/update" : "update"
    "imdb/:id" : "show_imdb"
    ".*" : "index"
