describe "Pages", ->
  beforeEach ->
    fixture.load("puzzle.html")

  describe "getCoords", ->
    it "returns an array of column number and row number from an object", ->
      expect(getCoords $('.ire')).toEqual [1, 2]

  describe "Map", ->
    it "can make a map", ->
      map = new PuzzleMap
