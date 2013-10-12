describe "The global application", ->

  fakeMoviesRsps = [
    responseText : '[{"movie": "1"}, {"movie": "2"}]'
    responseText : '[]'
  ]

  i = 0

  nextFakeMoviesRsp = () ->
    rsp = fakeMoviesRsps[i]
    i++
    rsp

  describe "namespaces", ->
    it "should define a Models namespace", ->
      expect(Shothere.Models).toBeDefined()
    it "should define a Routers namespace", ->
      expect(Shothere.Routers).toBeDefined()
    it "should define a Controllers namespace", ->
      expect(Shothere.Controllers).toBeDefined()
    it "should define a Collections namespace", ->
      expect(Shothere.Collections).toBeDefined()
    it "should define a Views namespace", ->
      expect(Shothere.Views).toBeDefined()
  describe "object", ->
    it "should be instanciated", ->
      expect(Shothere.App).toBeDefined()
      expect(Shothere.App).not.toBe(null)
    describe "starting", ->
      beforeEach ->
        spyOn($, "ajax").andCallFake (params) => params.complete nextFakeMoviesRsp()
        spyOn($, "parseJSON").andCallThrough()
        spyOn Backbone.history, "start"
        spyOn(Shothere.Controllers, "MoviesController").andReturn load: ->
        spyOn Shothere.Routers, "MainRouter"
        Shothere.App.start {}

      it "should create the main router with its controller and start backbone's history then should make an ajax call to get movies to populate the app", ->
        expect(Shothere.Controllers.MoviesController).toHaveBeenCalled()
        expect(Shothere.Routers.MainRouter).toHaveBeenCalledWith({controller: new Shothere.Controllers.MoviesController()})
        expect(Backbone.history.start).toHaveBeenCalled()
        expect($.ajax).toHaveBeenCalled()
        expect($.parseJSON).toHaveBeenCalledWith(fakeMoviesRsps[0].responseText)