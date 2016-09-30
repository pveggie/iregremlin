# This contains moves triggered by player interaction with the puzzle
class @Player
  @browseMoves: (target, puzzle, range) ->
    targetObject = $('#' + target.id)

    path = puzzle.getPath targetObject
    Puzzle.domHighlightPath path, range

  @makeMove: (target, puzzle, ire) ->
    # get actual cell object from clicked cell
    targetObject = $('#' + target.id)
    enemy = if targetObject.data('cellType') is "enemy" then true else false

    path = puzzle.getPath targetObject
    ire.move path if path.length <= ire.range and path.length isnt 0

    ire.fightEnemy targetObject if enemy

    targetType = targetObject.data('cellType')
    ire.range = if targetType is 'enemy' then 6 else 5
