# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.playerBrowsing = (target, puzzle, range) ->
  targetObject = $('#' + target.id)

  path = puzzle.getPath targetObject
  Puzzle.domHighlightPath path, range

window.playerMove = (target, puzzle, ire) ->
  # get actual cell object from clicked cell
  targetObject = $('#' + target.id)
  enemy = if targetObject.data('cellType') is "enemy" then true else false

  path = puzzle.getPath targetObject
  ire.move path if path.length <= ire.range and path.length isnt 0

  ire.fightEnemy targetObject if enemy

  targetType = targetObject.data('cellType')
  ire.range = if targetType is 'enemy' then 6 else 5


$(document).ready ->
  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  puzzle = new Puzzle
  ire = new Ire

  # --- EVENTS --------------------------------------------------
  # # Checking paths (hover)
  $('td').on 'mouseenter.userTurn', -> playerBrowsing this, puzzle, ire.range
  $('table').on 'mouseleave.userTurn', -> removeHighlighting()

  # Confirm Destination
  $('td').on 'click.userTurn', -> playerMove this, puzzle, ire


