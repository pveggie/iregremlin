# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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


