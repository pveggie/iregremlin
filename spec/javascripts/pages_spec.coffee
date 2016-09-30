describe "Pages", ->
  puzzle = null
  ire = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")

  describe "Methods", ->
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


