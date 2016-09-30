class @Ire
  range: 5
  hp: 20

  fightEnemy: (target) ->

  move: (path) ->
    Puzzle.domRemoveHighlighting()

    for step in path
      coords = step[0] + "-" + step[1]
      oldCell = $('td[data-cell-type="ire"]')
      nextCell = $('#' + coords)
      Puzzle.domUpdateIreLocation oldCell, nextCell
