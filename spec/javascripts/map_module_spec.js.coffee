describe "The Map Module", ->
  beforeEach ->
    @mapModule = Shothere.App.MapModule
  it "should exist", ->
    expect(@mapModule).toBeDefined()

  describe "starting", ->
    beforeEach ->
      @fakeLayer = 'm3:/#é231dqls'
      spyOn(L, "map").andReturn jasmine.createSpyObj('map', ['setView', 'hasLayer', 'addLayer'])
      spyOn(L, "TileLayer")
      spyOn(L, "layerGroup").andReturn jasmine.createSpyObj('group', ['clearLayers', 'addLayer'])
      fixture.set '<div id="map"></div>'
      @mapModule.start()
    afterEach ->
      @mapModule.stop()
      fixture.cleanup()
    it "should create at least one TileLayer", ->
      expect(L.TileLayer).toHaveBeenCalledWith(jasmine.any(String), jasmine.any(Object))

    it "should create a #oneMovie layer group", ->
      expect(L.layerGroup).toHaveBeenCalled()

    it "should create a leaflet map object containing a TileLayer", ->
      expect(L.map).toHaveBeenCalledWith("map", jasmine.any(Object))
      expect(L.map.mostRecentCall.args[1].layers).toContain jasmine.any(L.TileLayer)

    it "should redefine the imagePath of leaflet object", ->
      expect(L.Icon.Default.imagePath).toBe("/assets/")

    describe "#updateMarkers", ->
      beforeEach ->
        @mapModule.map.setView.reset()
        @model = jasmine.createSpyObj("movie", ["markers"])
        @getCenter = jasmine.createSpy("getCenter").andReturn [48.32, 2.23]
        @getBounds = jasmine.createSpy("getBounds").andReturn {getCenter: @getCenter}
        @model.markers.andReturn {getBounds: @getBounds}
        @mapModule.updateMarkers(@model)
      it "should clear layers contained in the #oneMovie layer group", ->
        expect(@mapModule.oneMovieLayer.clearLayers).toHaveBeenCalled()
      it "retrieve the markers from the model", ->
        expect(@model.markers).toHaveBeenCalled()
      it "and add them to the #oneMovie layer group", ->
        expect(@mapModule.oneMovieLayer.addLayer).toHaveBeenCalledWith(@model.markers())
      it "should check that the #oneMovie layer group is visible", ->
        expect(@mapModule.map.hasLayer).toHaveBeenCalledWith(@mapModule.oneMovieLayer)
        expect(@mapModule.map.addLayer).toHaveBeenCalled()
      it "and finally center the view on the markers", ->
        expect(@mapModule.map.setView).toHaveBeenCalledWith([48.32, 2.23] , jasmine.any(Number))
        expect(@model.markers().getBounds().getCenter).toHaveBeenCalled()