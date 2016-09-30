describe "Ire", ->
  ire = null

  beforeEach ->
    fixture.load("puzzle.html")
    ire = new Ire

  describe "properties", ->
    it "include an initial movement range of 5", ->
      expect(ire.range).toBe(5)

    it "include an initial HP of 20", ->
      expect(ire.hp).toBe(20)

  describe "methods", ->
    # ---------------------------------------------------------------
    describe "ire#move", ->
      it "moves Ire along the path", ->
        path = [[1,1], [1,0]]
        ire.move path
        expect($('#1-0')).toHaveClass('ire')

      it "removes path highlighting", ->
        path = [[1,1], [1,0]]
        Puzzle.domHighlightPath path
        ire.move path
        expect($('#1-0 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-0 div.highlighter-red').css('opacity')).toBe('0')
