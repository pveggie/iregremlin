class @Ire
  range: 5
  hp: 20
  weapon: null

  move: (path) ->
    Puzzle.domRemoveHighlighting()

    for step in path
      coords = step[0] + "-" + step[1]
      oldCell = $('td[data-cell-type="ire"]')
      nextCell = $('#' + coords)
      Puzzle.domUpdateIreLocation oldCell, nextCell

  fightEnemy: (target) ->
    oldCell = $('td[data-cell-type="ire"]')
    Puzzle.domUpdateIreLocation oldCell, target
