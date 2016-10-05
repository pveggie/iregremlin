# This class deals with properties of the puzzle, getting and setting
# information about the puzzle object and checking/changing the puzzle
# in the DOM.
# Organisation is as follows:
# 1. Default properties
# 2. Methods for changing properties for puzzle instances
# 3. Methods for getting information from a puzzle object
# 4. Methods for getting information from the DOM
# 5. Methods for changing the DOM
#
class @Puzzle
  # -- Properties ------------------------------------------------------
  constructor: ->
    @number = parseInt $('#info-number').text()
    @round = parseInt $('#info-round').text()
    @enemies = parseInt $('#info-enemies').text()

    # get number of rows and create blank walkability matrix
    numRows = Math.sqrt $('td').length
    # Assuming all maps are square
    @walkable = new Array(numRows)
    for num in [0...numRows]
      @walkable[num] = new Array(numRows)

  # -- Instance Methods that change properties -------------------------
  updateWalkable: ->
    # Define matrix for use in iterator becuase in the iterator
    # 'this/@' is the td rather than the puzzle object
    walkable = @walkable

    $('td').each ->
      # td objects are different from the ones obtained with class
      # selectors. They don't respond to attr method, but instead
      # id can be called directly.
      coords = @id.split '-'
      col = parseInt coords[0]
      row = parseInt coords[1]

      type = @dataset.cellType
      walkable[row][col] = if type is "empty" then 0 else 1

  # -- Instance Methods that don't change properties

  getPath: (targetObject) ->
     # Use pathfinding library to calculate shortest path,
     # accounting for obstacles
    @updateWalkable()
    walkabilityMatrix = @walkable

    grid = new PF.Grid walkabilityMatrix

    # get coordinates for the path calculator
    ireLoc = Puzzle.domGetCoords $('td[data-cell-type="ire"]')
    targetLoc = Puzzle.domGetCoords targetObject

    # make enemy walkable so path to it can be generated
    if targetObject.data('cellType') is "enemy"
      # setWalkable is a pathfinder method
      grid.setWalkableAt(targetLoc[0], targetLoc[1], true);

    finder = new PF.AStarFinder

    # 0 is x coordinate (column) and 1 is y coordinate (row)
    path = finder.findPath ireLoc[0], ireLoc[1], targetLoc[0], targetLoc[1], grid
    # to get rid of the first array element, which is the starting square
    path.shift()
    path

  # -- Class Methods for getting info from DOM -------------------------------

  @domGetCoords: (cellObject) ->
    # Get Ire and Target coordinates for the path calculator
    # Note that this requires correct type of object. Object from selector works,
    # object directly from user click does not.
    coords = cellObject.attr('id').split '-'
    coords.map (coord) ->
      parseInt coord

  # -- Class Methods for changing DOM -------------------------------

  @domRemoveHighlighting: ->
    $('.highlighter-blue').css('opacity', 0)
    $('.highlighter-red').css('opacity', 0)

  @domHighlightPath: (path, range) ->
    Puzzle.domRemoveHighlighting()

    highlighter = if path.length <= range then '.highlighter-blue' else '.highlighter-red'
    for step in path
      coords = step[0] + "-" + step[1]
      # e.g. $('#1-1 div.highlighter-red').css('opacity', 0.5)
      cell = $('#' + coords + " div" + highlighter)
      cell.css('opacity', 0.5)

  @domUpdateIreLocation: (oldCell, nextCell) ->
    # Note oldCell.data('cellType', 'empty') does not set the value in the DOM
    if nextCell.attr('data-cell-type') is 'enemy'
      ireType = ('ire-' + nextCell.attr('class'))
    else
      ireType = oldCell.attr('class')

    # Update DOM for old cell
    oldCell
      .removeClass()
      .addClass('empty')
      .attr('data-cell-type', "empty")

    # Update DOM for new cell
    nextCell
      .removeClass()
      .addClass(ireType)
      .attr('data-cell-type', "ire")

  domUpdatePuzzleInfo: (ire) ->
    $('#info-round').text(@round)
    $('#info-enemies').text(@enemies)

    $('#info-hp').text(ire.hp)
    $('#info-range').text(ire.range)
    capitalizedWeapon = ire.weapon.charAt(0).toUpperCase() + ire.weapon.slice(1)
    $('#info-weapon').text(capitalizedWeapon)

  @domInformWin: ->
    alert("Well done! You won!")

  @domInformLose: ->
    alert("Oh dear, you lost...")
