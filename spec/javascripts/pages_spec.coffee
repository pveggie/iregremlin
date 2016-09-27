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
        highlightPath path
        steps = ["1-1", "1-0", "2-0", "3-0", "3-1"]
        for cell in steps
          blueHighlighter = $('#' + cell + " div.highlighter-blue")
          redHighlighter = $('#' + cell + " div.highlighter-red")
          expect(blueHighlighter.css('opacity')).toBe('0.5')
          expect(redHighlighter.css('opacity')).toBe('0')

      it "highlights path to unreachable spot in red", ->
        path = [[1,1], [1,0], [2,0], [3,0], [4,0], [4,1]]
        highlightPath path
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

        highlightPath path for path in paths

        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-1 div.highlighter-red').css('opacity')).toBe('0')
        expect($('#1-3 div.highlighter-blue').css('opacity')).toBe('0.5')

    describe "updateDOM", ->
      beforeEach ->
        oldCell = $('#1-2')
        newCell = $('#1-1')
        updateDOM oldCell, newCell

      it "removes the ire class from the old cell", ->
        expect($('#1-2')).not.toHaveClass('ire')

      it "adds the empty class to the old cell", ->
        expect($('#1-2')).toHaveClass('empty')

      it "sets the old cell's cell-type data to empty", ->
        expect($('#1-2')).toHaveAttr('data-cell-type', 'empty')

      it "adds the ire class to the new cell", ->
        expect($('#1-1')).toHaveClass('ire')

      it "removes any other classes from the old cell", ->
        expect($('#1-1')).toHaveAttr('class', 'ire')

      it "sets the new cell's cell-type data to ire", ->
        expect($('#1-1')).toHaveAttr('data-cell-type', 'ire')

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


