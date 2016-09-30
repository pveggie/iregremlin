# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Get Ire and Target coordinates for the path calculator
# Note that this requires correct type of object. Object from selector works,
# object directly from user click does not.
window.getCoords = (cellObject) ->
  coords = cellObject.attr('id').split '-'
  coords.map (coord) ->
    parseInt coord

# Use pathfinding library to calculate shortest path, accounting for obstacles
window.findPath = (targetObject, puzzle) ->
  puzzle.updateWalkable()
  walkabilityMatrix = puzzle.walkable

  grid = new PF.Grid walkabilityMatrix

  # get coordinates for the path calculator
  ireLoc = getCoords $('td[data-cell-type="ire"]')
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

window.highlightPath = (path, range) ->
  removeHighlighting()

  highlighter = if path.length <= range then '.highlighter-blue' else '.highlighter-red'
  for step in path
    coords = step[0] + "-" + step[1]
    cell = $('#' + coords + " div" + highlighter)
    cell.css('opacity', 0.5)

window.updateDOM = (oldCell, nextCell) ->
# Update DOM for old cell
  # Note oldCell.data('cellType', 'empty') does not set the value in the DOM
  if nextCell.attr('data-cell-type') is 'enemy'
    ireType = ('ire-' + nextCell.attr('class'))
  else
    ireType = oldCell.attr('class')

  oldCell
    .removeClass()
    .addClass('empty')
    .attr('data-cell-type', "empty")

  # Update DOM for new cell
  nextCell
    .removeClass()
    .addClass(ireType)
    .attr('data-cell-type', "ire")

window.moveIre = (path) ->
  removeHighlighting()

  for step in path
    coords = step[0] + "-" + step[1]
    oldCell = $('td[data-cell-type="ire"]')
    nextCell = $('#' + coords)
    updateDOM oldCell, nextCell

window.removeHighlighting = ->
  $('.highlighter-blue').css('opacity', 0)
  $('.highlighter-red').css('opacity', 0)

window.playerBrowsing = (target, puzzle, range) ->
  targetObject = $('#' + target.id)

  path = findPath targetObject, puzzle
  highlightPath path, range

window.playerMove = (target, puzzle, ire) ->
  # get actual cell object from clicked cell
  targetObject = $('#' + target.id)
  enemy = if targetObject.data('cellType') is "enemy" then true else false

  path = findPath targetObject, puzzle
  moveIre path if path.length <= ire.range and path.length isnt 0

  ire.fightEnemy targetObject if enemy

  targetType = targetObject.data('cellType')
  ire.range = if targetType is 'enemy' then 6 else 5


$(document).ready ->
  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  puzzle = new Puzzle
  ire = new Ire

  # --- EVENTS --------------------------------------------------
  # # Checking paths (hover)
  $('td').on 'mouseenter.userTurn', -> plazerBrowsing this, puzzle, ire.range
  $('table').on 'mouseleave.userTurn', -> removeHighlighting()

  # Confirm Destination
  $('td').on 'click.userTurn', -> playerMove this, puzzle, ire


