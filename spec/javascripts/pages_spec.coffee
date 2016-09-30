describe "Pages", ->
  puzzle = null
  ire = null

  beforeEach ->
    # 25 cells, 5 rows, 5 columns
    fixture.load("puzzle.html")

  describe "Methods", ->
    # # ---------------------------------------------------------------
    # describe "updateDOM", ->
    #   oldCell = null
    #   newCell = null

    #   beforeEach ->
    #     oldCell = $('#1-2')
    #     newCell = $('#1-1')

    #   describe "oldCell", ->
    #     beforeEach ->
    #       updateDOM oldCell, newCell

    #     it "removes the ire class from the old cell", ->
    #       expect(oldCell).not.toHaveClass('ire')

    #     it "adds the empty class to the old cell", ->
    #       expect(oldCell).toHaveClass('empty')

    #     it "sets the old cell's cell-type data to empty", ->
    #       expect(oldCell).toHaveAttr('data-cell-type', 'empty')

    #   describe "newCell", ->
    #     beforeEach ->
    #       updateDOM oldCell, newCell

    #     it "adds the ire class to the new cell", ->
    #       expect(newCell).toHaveClass('ire')

    #     it "removes any other classes from the old cell", ->
    #       expect(newCell).toHaveAttr('class', 'ire')

    #     it "sets the new cell's cell-type data to ire", ->
    #       expect(newCell).toHaveAttr('data-cell-type', 'ire')

    #   describe "moving a weapon-wielding Ire", ->
    #     it "sets the old cell class to empty", ->
    #       oldCell.removeClass().addClass('ire-axe')
    #       updateDOM oldCell, newCell

    #       expect(oldCell).toHaveAttr('class', 'empty')

    #     it "can set the new cell class to ire-axe", ->
    #       oldCell.removeClass().addClass('ire-axe')
    #       updateDOM oldCell, newCell

    #       expect(newCell).toHaveAttr('class', 'ire-axe')

    #     it "can set the new cell class to ire-lance", ->
    #       oldCell.removeClass().addClass('ire-lance')
    #       updateDOM oldCell, newCell

    #       expect(newCell).toHaveAttr('class', 'ire-lance')

    #     it "can set the new cell class to ire-sword", ->
    #       oldCell.removeClass().addClass('ire-sword')
    #       updateDOM oldCell, newCell

    #       expect(newCell).toHaveAttr('class', 'ire-sword')

    #   describe "stealing enemy weapons", ->
    #     it "sets the new cell type to ire-axe after defeating axe", ->
    #       oldCell = $('#3-3')
    #       newCell = $('#3-2')
    #       oldCell.removeClass().addClass('ire-sword')

    #       updateDOM oldCell, newCell
    #       expect(newCell).toHaveAttr('class', 'ire-axe')

    #     it "sets the new cell type to ire-lance after defeating lance", ->
    #       oldCell = $('#3-3')
    #       newCell = $('#4-2')
    #       oldCell.removeClass().addClass('ire-sword')

    #       updateDOM oldCell, newCell
    #       expect(newCell).toHaveAttr('class', 'ire-lance')

    #     it "sets the new cell type to ire-sword after defeating sword", ->
    #       oldCell = $('#3-0')
    #       newCell = $('#3-1')
    #       oldCell.removeClass().addClass('ire-lance')

    #       updateDOM oldCell, newCell
    #       expect(newCell).toHaveAttr('class', 'ire-sword')

    # # ---------------------------------------------------------------
    # describe "moveIre", ->
    #   it "moves Ire along the path", ->
    #     path = [[1,1], [1,0]]
    #     moveIre path
    #     expect($('#1-0')).toHaveClass('ire')

    #   it "removes path highlighting", ->
    #     path = [[1,1], [1,0]]
    #     highlightPath path
    #     moveIre path
    #     expect($('#1-0 div.highlighter-blue').css('opacity')).toBe('0')
    #     expect($('#1-0 div.highlighter-red').css('opacity')).toBe('0')


    # # ---------------------------------------------------------------
    # describe "playerBrowsing", ->
    #   it "highlights paths based on where mouse hovers", ->
    #     puzzle = new Puzzle
    #     target = document.getElementById('1-1')

    #     playerBrowsing target, puzzle, 5
    #     expect($('#1-1 div.highlighter-blue').css('opacity')).toBe('0.5')

    # # ---------------------------------------------------------------
    # describe "playerMove", ->
    #   beforeEach ->
    #     puzzle = new Puzzle
    #     ire = new Ire

    #   describe "Moving ire", ->
    #     it "moves ire when the user clicks on a valid and reachable target", ->
    #       target = document.getElementById('4-0')

    #       playerMove target, puzzle, ire
    #       expect($('#4-0')).toHaveClass('ire')

    #     it "does not move ire when the target is too far away", ->
    #       target = document.getElementById('4-1')

    #       playerMove target, puzzle, ire
    #       expect($('#4-1')).not.toHaveClass('ire')

    #     it "does not move ire to an invalid target", ->
    #       target = document.getElementById('2-2')

    #       playerMove target, puzzle, ire
    #       expect($('#2-2')).not.toHaveClass('ire')

    #   describe "Updating the movement range", ->
    #     it "increases ire's movement range to 6 after Ire defeats an enemy", ->
    #       target = document.getElementById('3-1')

    #       playerMove target, puzzle, ire
    #       expect(ire.range).toBe(6)

    #     it "sets ire's movement range to 5 if Ire moves to non-enemy square", ->
    #       ire.range = 6
    #       target = document.getElementById('3-0')

    #       playerMove target, puzzle, ire
    #       expect(ire.range).toBe(5)

    #   describe "Fighting enemy", ->
    #     fightEnemy = null

    #     beforeEach ->
    #       ire =
    #         fightEnemy: (target, ire) ->
    #       spyOn(ire, 'fightEnemy')

    #     it "calls the fightEnemy method when target is an enemy", ->
    #       target = document.getElementById('3-1')
    #       playerMove target, puzzle, ire

    #       # window.fightEnemy()
    #       expect(ire.fightEnemy).toHaveBeenCalled()

    #     it "does not call the fightEnemy method when target is not an enemy", ->
    #       target = document.getElementById('3-0')
    #       playerMove target, puzzle, ire

    #       expect(ire.fightEnemy).not.toHaveBeenCalled()


