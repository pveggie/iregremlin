# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # build matrix of walkable and non-walkable cells
  matrix = [
    [0, 0, 0, 1, 0],
    [1, 0, 0, 0, 1],
    [0, 0, 1, 0, 0],
  ]

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
  console.log path

  console.log path.length

  # Check path is short enough
  validDestination = path.length <= 5


