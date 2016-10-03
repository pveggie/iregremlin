class @Ire
  range: 5
  hp: 20
  weapon: "none"

  move: (path) ->
    Puzzle.domRemoveHighlighting()

    for step in path
      coords = step[0] + "-" + step[1]
      oldCell = $('td[data-cell-type="ire"]')
      nextCell = $('#' + coords)
      Puzzle.domUpdateIreLocation oldCell, nextCell

  fightEnemy: (target) ->
    oldCell = $('td[data-cell-type="ire"]')
    enemyWeapon = target.attr('class')

    @hp -= @damageTaken @weapon, enemyWeapon
    @weapon = enemyWeapon
    Puzzle.domUpdateIreLocation oldCell, target

  damageTaken: (ireWeapon, enemyWeapon) ->
    weaponTriangle = ["sword", "lance", "axe"]
    ireIndex = weaponTriangle.indexOf ireWeapon
    enemyIndex = weaponTriangle.indexOf enemyWeapon

    if ireWeapon is "none" then 0
    else if ireIndex is enemyIndex + 1 or ireIndex is 0 and enemyIndex is 2
      0
    else if ireIndex is enemyIndex
      2
    else if ireIndex is enemyIndex - 1 or ireIndex is 2 and enemyIndex is 0
      5

