# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  puzzle = new Puzzle
  ire = new Ire

  # --- EVENTS --------------------------------------------------
  #Mobile Phone
  $('td').on 'tap.userTurn', -> Player.mobileMoves this, puzzle, ire

  # # Checking paths (hover)
  # $('td').on 'mouseenter.userTurn', -> Player.browseMoves this, puzzle, ire.range
  # $('table').on 'mouseleave.userTurn', -> Puzzle.domRemoveHighlighting()

  # # Confirm Destination
  # $('td').on 'mousedown.userTurn', -> Player.makeMove this, puzzle, ire




