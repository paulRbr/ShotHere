describe "The Map Module", ->
  beforeEach ->
    @mapModule = Shothere.App.MapModule
  it "should exist", ->
    expect(@mapModule).toBeDefined()

  describe "starting", ->
    beforeEach ->
      @fakeLayer = 'm3:/#é231dqls'
      spyOn(L, "map").and.returnValue jasmine.createSpyObj('map', ['setView', 'hasLayer', 'addLayer'])
      spyOn(L, "TileLayer")
      spyOn(L, "layerGroup").and.returnValue jasmine.createSpyObj('group', ['clearLayers', 'addLayer'])
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
        @getCenter = jasmine.createSpy("getCenter").and.returnValue [48.32, 2.23]
        @getBounds = jasmine.createSpy("getBounds").and.returnValue {getCenter: @getCenter}
        spyOn(@mapModule, "getMarkersOf").and.returnValue {getBounds: @getBounds}
        @markers = @mapModule.getMarkersOf(@model)
        @mapModule.updateMarkers(@model)
      it "should clear layers contained in the #oneMovie layer group", ->
        expect(@mapModule.oneMovieLayer.clearLayers).toHaveBeenCalled()
      it "retrieve the markers from the model", ->
        expect(@mapModule.getMarkersOf).toHaveBeenCalledWith(@model)
      it "and add them to the #oneMovie layer group", ->
        expect(@mapModule.oneMovieLayer.addLayer).toHaveBeenCalledWith(@markers)
      it "should check that the #oneMovie layer group is visible", ->
        expect(@mapModule.map.hasLayer).toHaveBeenCalledWith(@mapModule.oneMovieLayer)
        expect(@mapModule.map.addLayer).toHaveBeenCalled()
      it "and finally center the view on the markers", ->
        expect(@mapModule.map.setView).toHaveBeenCalledWith([48.32, 2.23] , jasmine.any(Number))
        expect(@markers.getBounds().getCenter).toHaveBeenCalled()
