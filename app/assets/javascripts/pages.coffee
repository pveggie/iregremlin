# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # get size of grid and create blank matrix array
  initializeMatrix = ->
    cellCount = $('td').length
    side = Math.sqrt cellCount

    matrix = new Array(side)
    for num in [0...side]
      matrix[num] = new Array(side)
    return matrix


  matrix = initializeMatrix()

  # fill matrix with walkable and non-walkable cells
  fillMatrix = ->
    $('td').each ->
      coords = @dataset.cellCoords.split '-'
      row = parseInt coords[0]
      col = parseInt coords[1]

      content = @dataset.cellContent
      if content is "empty"
        matrix[row][col] = 0
      else
        matrix[row][col] = 1
    return matrix


  # get Ire's location (start point)
  locateIre = ->
    coords = $('.ire').data().cellCoords.split '-'
    return coords.map ( coord ) ->
      parseInt coord

  ire = locateIre()

  # end location (user click)
  end_x = 4
  end_y = 2

  # Use pathfinding library to calculate shortest path, accounting for obstacles
  filledMatrix = fillMatrix()
  grid = new PF.Grid filledMatrix
  finder = new PF.AStarFinder

  path = finder.findPath ire[0], ire[1], end_x, end_y, grid

  # Check path is short enough
  validDestination = path.length <= 5


  console.log path
