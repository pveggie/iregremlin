# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require puzzle_map

# Get Ire and Target coordinates for the path calculator

# Note that this requires correct type of object. Object from selector works,
# object directly from user click does not.
window.getCoords = (cellObject) ->
  coords = cellObject.attr('id').split '-'
  coords.map (coord) ->
    parseInt coord

# Use pathfinding library to calculate shortest path, accounting for obstacles
window.findPath = (targetObject, puzzleMap) ->
  puzzleMap.updateMatrix()
  filledMatrix = puzzleMap.matrix

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
  # to get rid of the first array element, which is the starting square
  path.shift()
  path

window.highlightPath = (path) ->
  $('.highlighter-blue').css('opacity', 0)
  $('.highlighter-red').css('opacity', 0)

  highlighter = if path.length <= 5 then '.highlighter-blue' else '.highlighter-red'
  for step in path
    coords = step[0] + "-" + step[1]
    cell = $('#' + coords + " div" + highlighter)
    cell.css('opacity', 0.5)


moveIre = (path) ->
  for step in path
    coords = step[0] + "-" + step[1]
    oldCell = $('.ire')
    nextCell = $('#' + coords)
    updateDOM oldCell, nextCell

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

$(document).ready ->
  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  puzzleMap = new PuzzleMap

  # --- EVENTS --------------------------------------------------
  # # Checking paths (hover)
  $('td').mouseenter ->
    targetObject = $('#' + this.id)

    path = findPath targetObject, puzzleMap
    highlightPath path if path.length isnt 0

  # $('td').mouseleave ->
  #   $('.highlighter-blue').css('opacity', 0)
  #   $('.highlighter-red').css('opacity', 0)


  # Confirm Destination
  $('td').click ->
    # get actual cell object from clicked cell
    targetObject = $('#' + this.id)

    path = findPath targetObject, puzzleMap
    moveIre path if path.length <= 5 and path.length isnt 0


