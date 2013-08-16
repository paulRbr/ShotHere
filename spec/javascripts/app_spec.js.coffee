describe "The global application", ->
  describe "namespaces", ->
    it "should define a Models namespace", ->
      expect(Shothere.Models).toBeDefined()
    it "should define a Routers namespace", ->
      expect(Shothere.Routers).toBeDefined()
    it "should define a Collections namespace", ->
      expect(Shothere.Collections).toBeDefined()
    it "should define a Views namespace", ->
      expect(Shothere.Views).toBeDefined()
  describe "object", ->
    it "should be instanciated", ->
      expect(Shothere.App).toBeDefined()
      expect(Shothere.App).not.toBe(null)
    describe "when started", ->
      beforeEach ->
        spyOn Backbone.history, "start"
        spyOn Shothere.Routers, "MoviesRouter"
        Shothere.App.start({})
      it "should start the backbone history and create the main router", ->
        expect(Backbone.history.start).toHaveBeenCalled()
        expect(Shothere.Routers.MoviesRouter).toHaveBeenCalled()

