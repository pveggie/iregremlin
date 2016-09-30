# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # ---- RUN AS SOON AS DOCUMENT LOADS ---------------------------
  puzzle = new Puzzle
  ire = new Ire

  # --- EVENTS --------------------------------------------------
  # # Checking paths (hover)
  $('td').on 'mouseenter.userTurn', -> Player.browsing this, puzzle, ire.range
  $('table').on 'mouseleave.userTurn', -> Puzzle.domRemoveHighlighting()

  # Confirm Destination
  $('td').on 'click.userTurn', -> Player.move this, puzzle, ire


