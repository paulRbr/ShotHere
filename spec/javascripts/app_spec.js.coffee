describe "The global application", ->
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
        spyOn Backbone.history, "start"
        spyOn Shothere.Controllers, "MoviesController"
        spyOn Shothere.Routers, "MainRouter"
        Shothere.App.start({})
      it "should create the main router with its controller and start backbone's history", ->
        expect(Backbone.history.start).toHaveBeenCalled()
        expect(Shothere.Controllers.MoviesController).toHaveBeenCalled()
        expect(Shothere.Routers.MainRouter).toHaveBeenCalledWith({controller: new Shothere.Controllers.MoviesController()})

