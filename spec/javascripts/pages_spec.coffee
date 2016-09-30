describe "Pages", ->
  puzzle = null
  ire = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")

  describe "Methods", ->
    # ---------------------------------------------------------------
    describe "getCoords", ->
      it "returns an array of column number and row number from an object", ->
        expect(getCoords $('.ire')).toEqual [1, 2]

    # ---------------------------------------------------------------
    describe "findPath", ->
      beforeEach ->
        puzzle = new Puzzle

      it "returns an array of steps for a walkable target", ->
        # Ire is in 1-2, so this is two step away
        target = $('#1-0')
        expect(findPath target, puzzle).toEqual(
          [ [1,1], [1,0] ]
        )

      it "returns a blank array for a non-walkable target", ->
        target = $('#2-2')
        expect(findPath target, puzzle).toEqual([])

      it "accounts for obstacles", ->
        target = $('#4-1')
        expect(findPath target, puzzle).toEqual(
          [ [1,1], [1,0], [2,0], [3,0], [4,0], [4,1] ]
        )

      it "allows a target enemy to be walkable", ->
        target = $('#3-1')
        expect(findPath target, puzzle).toEqual(
          [ [1,1], [1,0], [2,0], [3,0], [3,1] ]
        )

      it "does not allow non-target enemies to be walkable", ->
        target = $('#3-3')
        expect(findPath target, puzzle).toEqual([])

    # ---------------------------------------------------------------
    describe "highlightPath", ->
      it "highlights path to reachable spot in blue", ->
        path = [[1,1], [1,0], [2,0], [3,0], [3,1]]
        highlightPath path, 5
        steps = ["1-1", "1-0", "2-0", "3-0", "3-1"]
        for cell in steps
          blueHighlighter = $('#' + cell + " div.highlighter-blue")
          redHighlighter = $('#' + cell + " div.highlighter-red")
          expect(blueHighlighter.css('opacity')).toBe('0.5')
          expect(redHighlighter.css('opacity')).toBe('0')

      it "highlights path to unreachable spot in red", ->
        path = [[1,1], [1,0], [2,0], [3,0], [4,0], [4,1]]
        highlightPath path, 5
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

        highlightPath path, 5 for path in paths

        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-1 div.highlighter-red').css('opacity')).toBe('0')
        expect($('#1-3 div.highlighter-blue').css('opacity')).toBe('0.5')

    # ---------------------------------------------------------------
    describe "updateDOM", ->
      oldCell = null
      newCell = null

      beforeEach ->
        oldCell = $('#1-2')
        newCell = $('#1-1')

      describe "oldCell", ->
        beforeEach ->
          updateDOM oldCell, newCell

        it "removes the ire class from the old cell", ->
          expect(oldCell).not.toHaveClass('ire')

        it "adds the empty class to the old cell", ->
          expect(oldCell).toHaveClass('empty')

        it "sets the old cell's cell-type data to empty", ->
          expect(oldCell).toHaveAttr('data-cell-type', 'empty')

      describe "newCell", ->
        beforeEach ->
          updateDOM oldCell, newCell

        it "adds the ire class to the new cell", ->
          expect(newCell).toHaveClass('ire')

        it "removes any other classes from the old cell", ->
          expect(newCell).toHaveAttr('class', 'ire')

        it "sets the new cell's cell-type data to ire", ->
          expect(newCell).toHaveAttr('data-cell-type', 'ire')

      describe "moving a weapon-wielding Ire", ->
        it "sets the old cell class to empty", ->
          oldCell.removeClass().addClass('ire-axe')
          updateDOM oldCell, newCell

          expect(oldCell).toHaveAttr('class', 'empty')

        it "can set the new cell class to ire-axe", ->
          oldCell.removeClass().addClass('ire-axe')
          updateDOM oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-axe')

        it "can set the new cell class to ire-lance", ->
          oldCell.removeClass().addClass('ire-lance')
          updateDOM oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-lance')

        it "can set the new cell class to ire-sword", ->
          oldCell.removeClass().addClass('ire-sword')
          updateDOM oldCell, newCell

          expect(newCell).toHaveAttr('class', 'ire-sword')

      describe "stealing enemy weapons", ->
        it "sets the new cell type to ire-axe after defeating axe", ->
          oldCell = $('#3-3')
          newCell = $('#3-2')
          oldCell.removeClass().addClass('ire-sword')

          updateDOM oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-axe')

        it "sets the new cell type to ire-lance after defeating lance", ->
          oldCell = $('#3-3')
          newCell = $('#4-2')
          oldCell.removeClass().addClass('ire-sword')

          updateDOM oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-lance')

        it "sets the new cell type to ire-sword after defeating sword", ->
          oldCell = $('#3-0')
          newCell = $('#3-1')
          oldCell.removeClass().addClass('ire-lance')

          updateDOM oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-sword')

    # ---------------------------------------------------------------
    describe "moveIre", ->
      it "moves Ire along the path", ->
        path = [[1,1], [1,0]]
        moveIre path
        expect($('#1-0')).toHaveClass('ire')

      it "removes path highlighting", ->
        path = [[1,1], [1,0]]
        highlightPath path
        moveIre path
        expect($('#1-0 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-0 div.highlighter-red').css('opacity')).toBe('0')

    # ---------------------------------------------------------------
    describe "removeHighlighting", ->
      it "removes any red highlighting", ->
        redHighlighter = $('#3-0 div.highlighter-red')
        redHighlighter.css('opacity', '0.5')

        removeHighlighting()
        expect(redHighlighter.css('opacity')).toBe('0')

      it "removes any blue highlighting", ->
        blueHighlighter = $('#3-0 div.highlighter-blue')
        blueHighlighter.css('opacity', '0.5')

        removeHighlighting()
        expect(blueHighlighter.css('opacity')).toBe('0')

    # ---------------------------------------------------------------
    describe "playerBrowsing", ->
      it "highlights paths based on where mouse hovers", ->
        puzzle = new Puzzle
        target = document.getElementById('1-1')

        playerBrowsing target, puzzle, 5
        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0.5')

    # ---------------------------------------------------------------
    describe "playerMove", ->
      beforeEach ->
        puzzle = new Puzzle
        ire = new Ire

      describe "Moving ire", ->
        it "moves ire when the user clicks on a valid and reachable target", ->
          target = document.getElementById('4-0')

          playerMove target, puzzle, ire
          expect($('#4-0')).toHaveClass('ire')

        it "does not move ire when the target is too far away", ->
          target = document.getElementById('4-1')

          playerMove target, puzzle, ire
          expect($('#4-1')).not.toHaveClass('ire')

        it "does not move ire to an invalid target", ->
          target = document.getElementById('2-2')

          playerMove target, puzzle, ire
          expect($('#2-2')).not.toHaveClass('ire')

      describe "Updating the movement range", ->
        it "increases ire's movement range to 6 after Ire defeats an enemy", ->
          target = document.getElementById('3-1')

          playerMove target, puzzle, ire
          expect(ire.range).toBe(6)

        it "sets ire's movement range to 5 if Ire moves to non-enemy square", ->
          ire.range = 6
          target = document.getElementById('3-0')

          playerMove target, puzzle, ire
          expect(ire.range).toBe(5)

      describe "Fighting enemy", ->
        fightEnemy = null

        beforeEach ->
          ire =
            fightEnemy: (target, ire) ->
          spyOn(ire, 'fightEnemy')

        it "calls the fightEnemy method when target is an enemy", ->
          target = document.getElementById('3-1')
          playerMove target, puzzle, ire

          # window.fightEnemy()
          expect(ire.fightEnemy).toHaveBeenCalled()

        it "does not call the fightEnemy method when target is not an enemy", ->
          target = document.getElementById('3-0')
          playerMove target, puzzle, ire

          expect(ire.fightEnemy).not.toHaveBeenCalled()


