

describe "Testing", ->
  it "is going so smoothly", ->
    expect(true).toBe true


# describe "getCoords", ->
#   it "returns an array of column number and row number from an object", ->
#     expect(getCoords $('.ire')).toBe [1,2]
# fixture.preload('puzzle.html')
  beforeEach ->
    fixture.load("puzzle.html")

  describe "Map", ->
    it "can make a map", ->
      map = new PuzzleMap
