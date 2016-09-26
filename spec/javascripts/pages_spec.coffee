

describe "Testing", ->
  it "is going so smoothly", ->
    expect(true).toBe true

#   it "is not going so smoothly", ->
#     expect(true).toBe false

# describe "getCoords", ->
#   it "returns an array of column number and row number from an object", ->
#     expect(getCoords $('.ire')).toBe [1,2]

  beforeEach ->
    fixture.load("puzzle.html")

  describe "Map", ->
    it "can make a map", ->
      map = new Map
