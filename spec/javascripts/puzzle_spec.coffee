describe "Puzzle", ->
  puzzle = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")
    puzzle = new Puzzle

  describe "properties", ->

    xit "include a number property", ->

    it "include a turn property with a starting value of 1", ->
      expect(puzzle.turn).toBe(1)

    xit "include a remainingEnemies property", ->

    describe "Puzzle#Constructor", ->
      it "creates a walkable cell matrix to represent the puzzle rows/columns", ->
        walkMatrix = puzzle.walkable
        expect(walkMatrix.length).toBe(5)
        expect(walkMatrix[0].length).toBe(5)

    describe "Instance Methods for setting properties", ->
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

    describe "Instance methods for getting information", ->
      describe "Puzzle#getPath", ->
      it "returns an array of steps for a walkable target", ->
        # Ire is in 1-2, so this is two step away
        target = $('#1-0')
        expect(puzzle.getPath target).toEqual(
          [ [1,1], [1,0] ]
        )

      it "returns a blank array for a non-walkable target", ->
        target = $('#2-2')
        expect(puzzle.getPath target).toEqual([])

      it "accounts for obstacles", ->
        target = $('#4-1')
        expect(puzzle.getPath target).toEqual(
          [ [1,1], [1,0], [2,0], [3,0], [4,0], [4,1] ]
        )

      it "allows a target enemy to be walkable", ->
        target = $('#3-1')
        expect(puzzle.getPath target).toEqual(
          [ [1,1], [1,0], [2,0], [3,0], [3,1] ]
        )

      it "does not allow non-target enemies to be walkable", ->
        target = $('#3-3')
        expect(puzzle.getPath target).toEqual([])

  describe "Getting info from DOM", ->
    # ---------------------------------------------------------------
    describe "Puzzle@domGetCoords", ->
      it "returns an array of column number and row number from an object", ->
        expect(Puzzle.domGetCoords $('.ire')).toEqual [1, 2]

    # ---------------------------------------------------------------

  describe "Updating DOM", ->
    # ---------------------------------------------------------------
    describe "Puzzle@domRemoveHighlighting", ->
      it "removes any red highlighting", ->
        redHighlighter = $('#3-0 div.highlighter-red')
        redHighlighter.css('opacity', '0.5')

        Puzzle.domRemoveHighlighting()
        expect(redHighlighter.css('opacity')).toBe('0')

      it "removes any blue highlighting", ->
        blueHighlighter = $('#3-0 div.highlighter-blue')
        blueHighlighter.css('opacity', '0.5')

        Puzzle.domRemoveHighlighting()
        expect(blueHighlighter.css('opacity')).toBe('0')
      # ---------------------------------------------------------------
      describe "Puzzle@domHighlightPath", ->

        it "highlights path to reachable spot in blue", ->
          path = [[1,1], [1,0], [2,0], [3,0], [3,1]]
          Puzzle.domHighlightPath path, 5
          steps = ["1-1", "1-0", "2-0", "3-0", "3-1"]
          for cell in steps
            blueHighlighter = $('#' + cell + " div.highlighter-blue")
            redHighlighter = $('#' + cell + " div.highlighter-red")
            expect(blueHighlighter.css('opacity')).toBe('0.5')
            expect(redHighlighter.css('opacity')).toBe('0')

        it "highlights path to unreachable spot in red", ->
          path = [[1,1], [1,0], [2,0], [3,0], [4,0], [4,1]]
          Puzzle.domHighlightPath path, 5
          steps = ["1-1", "1-0", "2-0", "3-0", "4-0", "4-1"]
          for cell in steps
            blueHighlighter = $('#' + cell + " div.highlighter-blue")
            redHighlighter = $('#' + cell + " div.highlighter-red")
            expect(blueHighlighter.css('opacity')).toBe('0')
            expect(redHighlighter.css('opacity')).toBe('0.5')


        it "unhighlights previously highlighted cells when the path changes", ->
          paths = [
            [[1,1], [1,0], [2,0], [3,0], [4,0], [4,1]],
            [[1,1]],
            [[1,3]]
          ]

          Puzzle.domHighlightPath path, 5 for path in paths

          expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0')
          expect($('#1-1 div.highlighter-red').css('opacity')).toBe('0')
          expect($('#1-3 div.highlighter-blue').css('opacity')).toBe('0.5')
