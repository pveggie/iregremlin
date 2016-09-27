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
        # Ire is in 1-2, so this is two step away
        map = new PuzzleMap
        target = $('#1-0')
        expect(findPath target, map).toEqual(
          [
            [1,1], [1,0]
          ]
        )

      it "returns a blank array for a non-walkable target", ->
        map = new PuzzleMap
        target = $('#2-2')
        expect(findPath target, map).toEqual(
          []
        )

      it "accounts for obstacles", ->
        map = new PuzzleMap
        target = $('#4-1')
        expect(findPath target, map).toEqual(
          [
            [1,1], [1,0], [2,0], [3,0], [4,0], [4,1]
          ]
        )

      it "allows a target enemy to be walkable", ->
        map = new PuzzleMap
        target = $('#3-1')
        expect(findPath target, map).toEqual(
          [
            [1,1], [1,0], [2,0], [3,0], [3,1]
          ]
        )

      it "does not allow non-target enemies to be walkable", ->
        map = new PuzzleMap
        target = $('#3-3')
        expect(findPath target, map).toEqual(
          []
        )

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

    describe "updateDOM", ->
      beforeEach ->
        oldCell = $('#1-2')
        newCell = $('#1-1')
        updateDOM oldCell, newCell

      describe "oldCell", ->
        it "removes the ire class from the old cell", ->
          expect($('#1-2')).not.toHaveClass('ire')

        it "adds the empty class to the old cell", ->
          expect($('#1-2')).toHaveClass('empty')

        it "sets the old cell's cell-type data to empty", ->
          expect($('#1-2')).toHaveAttr('data-cell-type', 'empty')

      describe "newCell", ->
        it "adds the ire class to the new cell", ->
          expect($('#1-1')).toHaveClass('ire')

        it "removes any other classes from the old cell", ->
          expect($('#1-1')).toHaveAttr('class', 'ire')

        it "sets the new cell's cell-type data to ire", ->
          expect($('#1-1')).toHaveAttr('data-cell-type', 'ire')

      describe "moving a weapon-wielding Ire", ->
        it "sets the old cell class to empty", ->
          oldCell = $('#1-2')
          newCell = $('#1-1')
          oldCell.removeClass().addClass('ire-axe')

          updateDOM oldCell, newCell
          expect(oldCell).toHaveAttr('class', 'empty')

        it "can set the new cell class to ire-axe", ->
          oldCell = $('#1-2')
          newCell = $('#1-1')
          oldCell.removeClass().addClass('ire-axe')

          updateDOM oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-axe')

        it "can set the new cell class to ire-lance", ->
          oldCell = $('#1-2')
          newCell = $('#1-1')
          oldCell.removeClass().addClass('ire-lance')

          updateDOM oldCell, newCell
          expect(newCell).toHaveAttr('class', 'ire-lance')

        it "can set the new cell class to ire-sword", ->
          oldCell = $('#1-2')
          newCell = $('#1-1')
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

    describe "moveIre", ->
      it "moves Ire to the last point on the path", ->
        path = [[1,1], [1,0]]
        moveIre path
        expect($('#1-0')).toHaveClass('ire')

      it "removes path highlighting", ->
        path = [[1,1], [1,0]]
        highlightPath path
        moveIre path
        expect($('#1-0 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-0 div.highlighter-red').css('opacity')).toBe('0')

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

    describe "browseMoves", ->
      it "highlights paths based on where mouse hovers", ->
        map = new PuzzleMap
        target = document.getElementById('1-1')

        browseMoves target, map, 5
        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0.5')

    describe "playerMakesMove", ->
      describe "Moving ire", ->
        it "moves ire when the user clicks on a valid and reachable target", ->
          map = new PuzzleMap
          ire = new Ire
          target = document.getElementById('4-0')

          playerMakesMove target, map, ire
          expect($('#4-0')).toHaveClass('ire')

        it "does not move ire when the target is too far away", ->
          map = new PuzzleMap
          ire = new Ire
          target = document.getElementById('4-1')

          playerMakesMove target, map, ire
          expect($('#4-1')).not.toHaveClass('ire')

        it "does not move ire to an invalid target", ->
          map = new PuzzleMap
          ire = new Ire
          target = document.getElementById('2-2')

          playerMakesMove target, map, ire
          expect($('#2-2')).not.toHaveClass('ire')

      describe "Updating the movement range", ->
        it "increases ire's movement range to 6 after Ire defeats an enemy", ->
          map = new PuzzleMap
          ire = new Ire
          target = document.getElementById('3-1')

          playerMakesMove target, map, ire
          expect(ire.range).toBe(6)

        it "sets ire's movement range to 5 if Ire moves to non-enemy square", ->
          map = new PuzzleMap
          ire = new Ire
          ire.range = 6
          target = document.getElementById('3-0')

          playerMakesMove target, map, ire
          expect(ire.range).toBe(5)
