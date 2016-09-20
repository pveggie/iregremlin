# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # get size of grid and create matrix array
  cellCount = $('td').length
  side = Math.sqrt cellCount
  console.log side

  matrix = new Array(side)
  for num in [0...side]
    matrix[num] = new Array(side)

  # fill matrix with walkable and non-walkable cells
  $('td').each ->
    coords = @dataset.cellCoords.split '-'
    row = parseInt coords[0]
    col = parseInt coords[1]

    content = @dataset.cellContent
    if content is "empty"
      matrix[row][col] = 0
    else
      matrix[row][col] = 1


  # get Ire's location (start point)
  start_x = 1
  start_y = 2

  # end location (user click)
  end_x = 4
  end_y = 2

  # Use pathfinding library to calculate shortest path, accounting for obstacles
  grid = new PF.Grid matrix
  finder = new PF.AStarFinder

  path = finder.findPath start_x, start_y, end_x, end_y, grid

  # Check path is short enough
  validDestination = path.length <= 5


