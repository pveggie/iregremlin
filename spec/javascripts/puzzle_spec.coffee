describe "Puzzle", ->
  puzzle = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")
    puzzle = new Puzzle

  describe "Attributes", ->
    describe "Puzzle#Constructor", ->
      xit "creates number as an attribute", ->

      it "creates turn as an attribute, with a starting value of 1", ->
        expect(puzzle.turn).toBe(1)

      xit "creates remaining enemies as an attribute", ->

      it "creates a walkable cell matrix to represent the puzzle rows/columns", ->
        walkMatrix = puzzle.walkable
        expect(walkMatrix.length).toBe(5)
        expect(walkMatrix[0].length).toBe(5)

  describe "Puzzle#updateWalkable", ->
    it "updates the map matrix to show walkable and non-walkable points", ->
      puzzle.updateWalkable()
      # 0 = walkable, 1 = non-walkable
      expect(puzzle.walkable).toEqual(
        [
          [0,0,0,0,0],
          [0,0,1,1,0],
          [0,1,1,1,1],
          [0,0,1,0,0],
          [1,1,1,1,1]
        ]
      )
