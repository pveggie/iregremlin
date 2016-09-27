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
