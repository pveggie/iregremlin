describe "Pages", ->
  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")

  describe "Methods", ->
    describe "getCoords", ->
      it "returns an array of column number and row number from an object", ->
        expect(getCoords $('.ire')).toEqual [1, 2]

    describe "findPath", ->
      it "returns an array of steps for a walkable target", ->
        map = new PuzzleMap
        # Ire is in 1-2, so this is one step away
        target = $('#1-1')
        expect(findPath target, map).toEqual(
          [
            [1,1]
          ]
        )

