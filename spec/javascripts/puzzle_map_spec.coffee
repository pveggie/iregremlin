describe "PuzzleMap", ->
  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")

  describe "PuzzleMap#constructor", ->
    it "creates new PuzzleMap with a matrix", ->
      map = new PuzzleMap
      expect(map.matrix).toExist

    it "creates an array representing the rows and columns of the puzzle", ->
      map = new PuzzleMap
      matrix = map.matrix
      expect(matrix.length).toBe(5)
      expect(matrix[0].length).toBe(5)

  describe "PuzzleMap#update", ->
    it "updates the map matrix to show walkable and non-walkable points", ->
      map = new PuzzleMap
      map.updateMatrix()
      # 0 = walkable, 1 = non-walkable
      expect(map.matrix).toEqual(
        [
          [0,0,0,0,0],
          [0,0,1,1,0],
          [0,1,1,1,1],
          [0,0,1,0,0],
          [1,1,1,1,1]
        ]
      )
