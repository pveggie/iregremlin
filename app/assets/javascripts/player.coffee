# This contains moves triggered by player interaction with the puzzle
class @Player
  @browseMoves: (target, puzzle, range) ->
    targetObject = $('#' + target.id)

    path = puzzle.getPath targetObject
    Puzzle.domHighlightPath path, range

  @makeMove: (target, puzzle, ire) ->
    # get actual cell object from clicked cell
    targetObject = $('#' + target.id)
    enemyTarget = false
    reachableTarget = false

    path = puzzle.getPath targetObject
    enemyTarget = true if targetObject.data('cellType') is "enemy"
    reachableTarget = true if path.length <= ire.range and path.length isnt 0

    if enemyTarget and reachableTarget
      # ire moves to the space before the enemy then attacks
      # then moves on to enemy square
      path.pop()
      ire.move path
      ire.fightEnemy targetObject

      ire.range = 6
      puzzle.enemies -= 1
      @checkStatus puzzle, ire

    else if reachableTarget and not enemyTarget
      ire.move path
      ire.range = 5
      puzzle.round += 1

    puzzle.domUpdatePuzzleInfo ire

  @checkStatus: (puzzle, ire) ->
    Puzzle.domInformWin() if puzzle.enemies is 0
    Puzzle.domInformLose() if ire.hp is 0


