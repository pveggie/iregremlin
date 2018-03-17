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

    it "include a weapon, which starts as 'None'", ->
      expect(ire.weapon).toBe("none")

  describe "methods", ->
    # ---------------------------------------------------------------
    describe "ire#move", ->
      path = []

      beforeEach ->
        path = [[1, 1], [1, 0]]

      it "moves Ire along the path", ->
        ire.move path
        expect($('#1-0')).toHaveClass('ire')

      it "removes path highlighting", ->
        Puzzle.domHighlightPath path
        ire.move path
        expect($('#1-0 div.highlighter-blue').css('opacity')).toBe('0')
        expect($('#1-0 div.highlighter-red').css('opacity')).toBe('0')

      it "calls the Puzzle@domUpdateIreLocation method", ->
        spyOn(Puzzle, 'domUpdateIreLocation')

        ire.move path
        expect(Puzzle.domUpdateIreLocation).toHaveBeenCalled()

      it "calls the domUpdate method for every step", ->
        spyOn(Puzzle, 'domUpdateIreLocation')

        ire.move path
        expect(Puzzle.domUpdateIreLocation.calls.count()).toBe(2)

    describe "ire#fightEnemy", ->
      swordEnemy = null

      beforeEach ->
        swordEnemy = $('#3-1')

      it "updates Ire's weapon to be the enemy's weapon", ->
        ire.fightEnemy swordEnemy
        expect(ire.weapon).toBe("sword")

      it "updates Ire's HP when ire takes damage", ->
        ire.weapon = "axe"
        hp = ire.hp

        ire.fightEnemy swordEnemy
        expect(ire.hp).toBeLessThan(hp)

    describe "_ire#damageTaken", ->
      describe "when ire has no weapon", ->
        it "is 0 when the enemy has a sword", ->
          expect(ire.damageTaken "none", "sword").toBe(0)

        it "is 0 when the enemy has a lance", ->
          expect(ire.damageTaken "none", "lance").toBe(0)

        it "is 0 when the enemy has an axe", ->
          expect(ire.damageTaken "none", "axe").toBe(0)


      describe "when ire has a lance", ->
        it "is 0 when the enemy has a sword", ->
          expect(ire.damageTaken "lance", "sword").toBe(0)

        it "is 2 when the enemy has a lance", ->
          expect(ire.damageTaken "lance", "lance").toBe(2)

        it "is 5 when the enemy has an axe", ->
          expect(ire.damageTaken "lance", "axe").toBe(5)


      describe "when ire has a sword", ->
        it "is 2 when the enemy has a sword", ->
          expect(ire.damageTaken "sword", "sword").toBe(2)

        it "is 5 when the enemy has a lance", ->
          expect(ire.damageTaken "sword", "lance").toBe(5)

        it "is 0 when the enemy has an axe", ->
          expect(ire.damageTaken "sword", "axe").toBe(0)


      describe "when ire has an axe", ->
        it "is 5 when the enemy has a sword", ->
          expect(ire.damageTaken "axe", "sword").toBe(5)

        it "is 0 when the enemy has a lance", ->
          expect(ire.damageTaken "axe", "lance").toBe(0)

        it "is 2 when the enemy has an axe", ->
          expect(ire.damageTaken "axe", "axe").toBe(2)




