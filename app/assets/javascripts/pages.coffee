# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  class Map
    # get size of grid and create blank matrix array
    constructor: ->
      numRows = Math.sqrt $('td').length
      # Assuming all maps are square
      @matrix = new Array(numRows)
      for num in [0...numRows]
        @matrix[num] = new Array(numRows)

    # update grid to reflect walkable and non-walkable cells
    updateMatrix: ->
      # Define matrix for use in iterator becuase in the iterator
      # 'this/@' is the td rather than the puzzle object
      matrix = @matrix

      $('td').each ->
        # td objects are different from the ones obtained with class
        # selectors. They don't respond to attr method, but instead
        # id can be called directly.
        coords = @id.split '-'
        col = parseInt coords[0]
        row = parseInt coords[1]

        type = @dataset.cellType
        matrix[row][col] = if type is "empty" then 0 else 1

  # -------------------------------------------------------------------

  # Get Ire and Target coordinates for the path calculator
  #
  # Note that this requires correct type of object. Object from selector works,
  # object directly from user click does not.
  getCoords = (cellObject) ->
    coords = cellObject.attr('id').split '-'
    coords.map (coord) ->
      parseInt coord

  # Use pathfinding library to calculate shortest path, accounting for obstacles
  findPath = (targetObject) ->
    map.updateMatrix()
    filledMatrix = map.matrix

    grid = new PF.Grid filledMatrix

    # get coordinates for the path calculator
    ireLoc = getCoords $('.ire')
    targetLoc = getCoords targetObject

    # make enemy walkable so path to it can be generated
    if targetObject.data('cellType') is "enemy"
      # setWalkable is a pathfinder method
      grid.setWalkableAt(targetLoc[0], targetLoc[1], true);

    finder = new PF.AStarFinder

    # 0 is x coordinate (column) and 1 is y coordinate (row)
    path = finder.findPath ireLoc[0], ireLoc[1], targetLoc[0], targetLoc[1], grid

  updateDOM = (oldCell, nextCell) ->
  # Update DOM for old cell
    # Note oldCell.data('cellType', 'empty') does not set the value in the DOM
    oldCell
      .addClass('empty')
      .removeClass('ire')
      .attr('data-cell-type', "empty")

    # Update DOM for new cell
    nextCell
      .removeClass()
      .addClass('ire')
      .attr('data-cell-type', "ire")

  moveIre = (path) ->
    for step in path
      coords = step[0] + "-" + step[1]
      oldCell = $('.ire')
      nextCell = $('#' + coords)
      updateDOM oldCell, nextCell

  # --- EVENTS --------------------------------------------------

  # end location (user click)
  $('td').click ->
    # get actual cell object from clicked cell
    targetObject = $('#' + this.id)

    path = findPath targetObject
    moveIre path if path.length <= 6 and path.length isnt 0

  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  map = new Map
