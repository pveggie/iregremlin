describe "Puzzle", ->
  puzzle = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")
    puzzle = new Puzzle

  describe "properties", ->

    it "include a number property", ->
      expect(puzzle.number).toBe(1)

    it "include a round property with a starting value of 1", ->
      expect(puzzle.round).toBe(1)

    it "include an enemies property", ->
      expect(puzzle.enemies).toBe(3)

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
              [0, 0, 0, 0, 0],
              [0, 0, 1, 1, 0],
              [0, 1, 1, 1, 1],
              [0, 0, 1, 0, 0],
              [1, 1, 1, 1 , 1]
            ]
          )

    describe "Instance methods for getting information", ->
      describe "Puzzle#getPath", ->
      it "returns an array of steps for a walkable target", ->
        # Ire is in 1-2, so this is two step away
        target = $('#1-0')
        expect(puzzle.getPath target).toEqual(
          [ [1, 1], [1, 0] ]
        )

      it "returns a blank array for a non-walkable target", ->
        target = $('#2-2')
        expect(puzzle.getPath target).toEqual([])

      it "accounts for obstacles", ->
        target = $('#4-1')
        expect(puzzle.getPath target).toEqual(
          [ [1, 1], [1, 0], [2, 0], [3, 0], [4, 0], [4, 1] ]
        )

      it "allows a target enemy to be walkable", ->
        target = $('#3-1')
        expect(puzzle.getPath target).toEqual(
          [ [1, 1], [1, 0], [2, 0], [3, 0], [3, 1] ]
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
      ire = {}
      range = null

      beforeEach ->
        ire.range = 5

      it "highlights path to reachable spot in blue", ->
        path = [[1, 1], [1, 0], [2, 0], [3, 0], [3, 1]]
        Puzzle.domHighlightPath path, ire.range
        steps = ["1-1", "1-0", "2-0", "3-0", "3-1"]
        for cell in steps
          blueHighlighter = $('#' + cell + " div.highlighter-blue")
          redHighlighter = $('#' + cell + " div.highlighter-red")
          expect(blueHighlighter.css('opacity')).toBe('0.5')
          expect(redHighlighter.css('opacity')).toBe('0')

      it "highlights path to unreachable spot in red", ->
        path = [[1, 1], [1, 0], [2, 0], [3, 0], [4, 0], [4, 1]]
        Puzzle.domHighlightPath path, ire.range
        steps = ["1-1", "1-0", "2-0", "3-0", "4-0", "4-1"]
        for cell in steps
          blueHighlighter = $('#' + cell + " div.highlighter-blue")
          redHighlighter = $('#' + cell + " div.highlighter-red")
          expect(blueHighlighter.css('opacity')).toBe('0')
          expect(redHighlighter.css('opacity')).toBe('0.5')


      it "unhighlights previously highlighted cells when the path changes", ->
        paths = [
          [[1, 1], [1, 0], [2, 0], [3, 0], [4, 0], [4, 1]],
          [[1, 1]],
          [[1, 3]]
        ]

        Puzzle.domHighlightPath path, ire.range for path in paths

        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-1 div.highlighter-red').css('opacity')).toBe('0')
        expect($('#1-3 div.highlighter-blue').css('opacity')).toBe('0.5')

    # ---------------------------------------------------------------
    describe "domUpdateIreLocation", ->
      oldCell = null
      newCell = null

      beforeEach ->
        oldCell = $('#1-2')
        newCell = $('#1-1')

      describe "oldCell", ->
        beforeEach ->
          Puzzle.domUpdateIreLocation oldCell, newCell

        it "removes the ire class from the old cell", ->
          expect(oldCell).not.toHaveClass('ire')

        it "adds the empty class to the old cell", ->
          expect(oldCell).toHaveClass('empty')

        it "sets the old cell's cell-type data to empty", ->
          expect(oldCell).toHaveAttr('data-cell-type', 'empty')

      describe "newCell", ->
        beforeEach ->
          Puzzle.domUpdateIreLocation oldCell, newCell

        it "adds the ire class to the new cell", ->
          expect(newCell).toHaveClass('ire')

        it "removes any other classes from the old cell", ->
          expect(newCell).toHaveAttr('class', 'ire')

        it "sets the new cell's cell-type data to ire", ->
          expect(newCell).toHaveAttr('data-cell-type', 'ire')

      describe "moving a weapon-wielding Ire", ->
        it "sets the old cell class to empty", ->
          oldCell.removeClass().addClass('ire-axe')
          Puzzle.domUpdateIreLocation oldCell, newCell

          expect(oldCell).toHaveAttr('class', 'empty')

        it "can set the new cell class to ire-axe", ->
          oldCell.removeClass().addClass('ire-axe')
          Puzzle.domUpdateIreLocation oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-axe')

        it "can set the new cell class to ire-lance", ->
          oldCell.removeClass().addClass('ire-lance')
          Puzzle.domUpdateIreLocation oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-lance')

        it "can set the new cell class to ire-sword", ->
          oldCell.removeClass().addClass('ire-sword')
          Puzzle.domUpdateIreLocation oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-sword')

      describe "stealing enemy weapons", ->
        it "sets the new cell type to ire-axe after defeating axe", ->
          oldCell = $('#3-3')
          newCell = $('#3-2')
          oldCell.removeClass().addClass('ire-sword')

          Puzzle.domUpdateIreLocation oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-axe')

        it "sets the new cell type to ire-lance after defeating lance", ->
          oldCell = $('#3-3')
          newCell = $('#4-2')
          oldCell.removeClass().addClass('ire-sword')

          Puzzle.domUpdateIreLocation oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-lance')

        it "sets the new cell type to ire-sword after defeating sword", ->
          oldCell = $('#3-0')
          newCell = $('#3-1')
          oldCell.removeClass().addClass('ire-lance')

          Puzzle.domUpdateIreLocation oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-sword')

      describe "puzzle#domUpdatePuzzleInfo", ->
        ire = {}

        beforeEach ->
          ire = new Ire

        it "updates the round number", ->
          puzzle.round = 10
          puzzle.domUpdatePuzzleInfo ire
          expect($('#info-round').text()).toBe('10')

        it "updates the number of enemies left", ->
          puzzle.enemies = 5
          puzzle.domUpdatePuzzleInfo ire
          expect($('#info-enemies').text()).toBe('5')

        it "updates the ire's hp", ->
          ire.hp = 50
          puzzle.domUpdatePuzzleInfo ire
          expect($('#info-hp').text()).toBe('50')

        it "updates ire's weapon", ->
          ire.weapon = "lance"
          puzzle.domUpdatePuzzleInfo ire
          expect($('#info-weapon').text()).toBe('Lance')

        it "updates the number of enemies left", ->
          ire.range = 12
          puzzle.domUpdatePuzzleInfo ire
          expect($('#info-range').text()).toBe('12')



