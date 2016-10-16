describe "Player", ->
  puzzle = null
  ire = null

  swordEnemy = null
  validBlank = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")
    swordEnemy = document.getElementById('3-1')
    validBlank = document.getElementById('4-0')

  describe "Methods", ->
    # ---------------------------------------------------------------
    describe "Player@browseMoves", ->
      it "highlights paths based on where mouse hovers", ->
        puzzle = new Puzzle
        target = document.getElementById('1-1')

        Player.browseMoves target, puzzle, 5
        expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0.5')

    # ---------------------------------------------------------------
    describe "Player@makeMove", ->
      beforeEach ->
        puzzle = new Puzzle
        ire = new Ire

      describe "Moving ire", ->

        it "calls the ire.move method", ->
          spyOn(ire, 'move')
          target = validBlank

          Player.makeMove target, puzzle, ire
          expect(ire.move).toHaveBeenCalled

        it "moves ire when the user clicks on a valid and reachable target", ->
          target = validBlank

          Player.makeMove target, puzzle, ire
          expect($('#4-0')).toHaveClass('ire')

        it "does not move ire when the target is too far away", ->
          target = document.getElementById('4-1')

          Player.makeMove target, puzzle, ire
          expect($('#4-1')).not.toHaveClass('ire')

        it "does not move ire to an invalid target", ->
          target = document.getElementById('2-2')

          Player.makeMove target, puzzle, ire
          expect($('#2-2')).not.toHaveClass('ire')

        it "ultimate moves ire onto enemy square when attacking and enemy", ->
          target = swordEnemy

          Player.makeMove target, puzzle, ire
          expect($('#3-1')).toHaveClass('ire-sword')


      describe "Fighting enemy", ->

        beforeEach ->
          spyOn(ire, 'fightEnemy')

        it "calls the fightEnemy method when target is an enemy", ->
          target = swordEnemy
          Player.makeMove target, puzzle, ire

          expect(ire.fightEnemy).toHaveBeenCalled()

        it "does not call the fightEnemy method when target is not an enemy", ->
          target = validBlank
          Player.makeMove target, puzzle, ire

          expect(ire.fightEnemy).not.toHaveBeenCalled()

      describe "Checking game status", ->

        it "calls the Player#checkStatus method if Ire fights", ->
          spyOn(Player, 'checkStatus')

          target = swordEnemy
          Player.makeMove target, puzzle, ire

          expect(Player.checkStatus).toHaveBeenCalled()

      describe "Updating JS Objects", ->
          it "is increases puzzle#round if Ire does not fight", ->
            round = puzzle.round
            target = validBlank
            Player.makeMove target, puzzle, ire

            expect(puzzle.round).toBe(round + 1)

          it "does not update puzzle#round if Ire fights", ->
            round = puzzle.round
            target = swordEnemy
            Player.makeMove target, puzzle, ire

            expect(puzzle.round).toBe(round)

          it "reduces puzzle#enemies when ire fights an enemy", ->
            enemies = puzzle.enemies

            target = swordEnemy
            Player.makeMove target, puzzle, ire
            expect(puzzle.enemies).toBe(enemies - 1)

          it "does not reduce puzzle#enemies when ire does not fight and enemy", ->
            enemies = puzzle.enemies

            target = validBlank
            Player.makeMove target, puzzle, ire
            expect(puzzle.enemies).toBe(enemies)

          it "increases ire#range to 6 after Ire defeats an enemy", ->
            target = swordEnemy

            Player.makeMove target, puzzle, ire
            expect(ire.range).toBe(6)

          it "sets ire#rage to 5 if Ire moves to non-enemy square", ->
            ire.range = 6
            target = validBlank

            Player.makeMove target, puzzle, ire
            expect(ire.range).toBe(5)

        describe "Updating puzzle info in DOM", ->
          it "calls puzzle#domUpdatePuzzleInfo", ->
            spyOn(puzzle, 'domUpdatePuzzleInfo')

            target = validBlank

            Player.makeMove target, puzzle, ire
            expect(puzzle.domUpdatePuzzleInfo).toHaveBeenCalled()

    # ---------------------------------------------------------------
    describe "Player@mobileMoves", ->
      beforeEach ->
        puzzle = new Puzzle
        ire = new Ire
        spyOn(Player,'browseMoves')
        spyOn(Player,'makeMove')

      describe "first click", ->
        it "calls the browseMoves method", ->
          Player.mobileMoves swordEnemy, puzzle, ire
          expect(Player.browseMoves).toHaveBeenCalled()

        it "does not call the makeMove method", ->
          Player.mobileMoves swordEnemy, puzzle, ire
          expect(Player.makeMove).not.toHaveBeenCalled()

      describe "confirm click for valid target", ->
        beforeEach ->
          $('#3-1 div.highlighter-blue').css('opacity', 0.5)

        it "calls the makeMove method", ->
          Player.mobileMoves swordEnemy, puzzle, ire
          expect(Player.makeMove).toHaveBeenCalled()

        it "does not call the browseMoves method", ->
          Player.mobileMoves swordEnemy, puzzle, ire
          expect(Player.browseMoves).not.toHaveBeenCalled()

      describe "confirm click on invalid target", ->
        target = null
        beforeEach ->
          target = document.getElementById('4-1')
          $('#3-1 div.highlighter-blue').css('opacity', 0)
          $('#3-1 div.highlighter-red').css('opacity', 0.5)

        it "calls the browseMoves method", ->
          Player.mobileMoves target, puzzle, ire
          expect(Player.browseMoves).toHaveBeenCalled()

        it "does not call the makeMove method", ->
          Player.mobileMoves target, puzzle, ire
          expect(Player.makeMove).not.toHaveBeenCalled()



    # ---------------------------------------------------------------
    describe "Player@checkStatus", ->
      beforeEach ->
        puzzle = new Puzzle
        ire = new Ire
        spyOn(Puzzle,'domInformLose')
        spyOn(Puzzle,'domInformWin')

      it "tells the player if they've lost", ->
        ire.hp = 0
        Player.checkStatus puzzle, ire
        expect(Puzzle.domInformLose).toHaveBeenCalled()

      it "tells the player if they've won", ->
        puzzle.enemies = 0
        Player.checkStatus puzzle, ire
        expect(Puzzle.domInformWin).toHaveBeenCalled()

      it "does not show win or lose messages when status is ongoing", ->
        expect(Puzzle.domInformLose).not.toHaveBeenCalled()
        expect(Puzzle.domInformWin).not.toHaveBeenCalled()




