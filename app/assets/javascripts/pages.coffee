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
      matrix = @matrix

      $('td').each (@matrix)->
        coords = @dataset.cellCoords.split '-'
        row = parseInt coords[0]
        col = parseInt coords[1]

        content = @dataset.cellContent
        matrix[row][col] = if content is "empty" then 0 else 1

  # -------------------------------------------------------------------

  # get Ire's location (start point)
  ireLocation = ->
    coords = $('.ire').data().cellCoords.split '-'
    return coords.map ( coord ) ->
      parseInt coord

  # get target location from user's click
  targetLocation = (clickedCell) ->
    coords = clickedCell.dataset.cellCoords.split '-'
    return coords.map (coord) ->
      parseInt coord

  # Use pathfinding library to calculate shortest path, accounting for obstacles
  checkPath = (ire, target) ->
    map.updateMatrix()
    filledMatrix = map.matrix
    console.log filledMatrix

    grid = new PF.Grid filledMatrix
    finder = new PF.AStarFinder

    # 0 is x coordinate and 1 is y coordinate
    path = finder.findPath ire[0], ire[1], target[0], target[1], grid


  # end location (user click)
  $('td').click ->
    ire = ireLocation()
    target = targetLocation this

    path = checkPath ire, target
    if path.length <= 6 then console.log "valid"  else console.log "invalid"
    console.log path

  map = new Map
