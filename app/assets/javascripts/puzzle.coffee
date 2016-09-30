class @Puzzle
  constructor: ->
    @turn = 1
    # Assuming all maps are square
    numRows = Math.sqrt $('td').length
    @walkable = new Array(numRows)
    for num in [0...numRows]
      @walkable[num] = new Array(numRows)

  updateWalkable: ->
    # Define matrix for use in iterator becuase in the iterator
    # 'this/@' is the td rather than the puzzle object
    walkable = @walkable

    $('td').each ->
      # td objects are different from the ones obtained with class
      # selectors. They don't respond to attr method, but instead
      # id can be called directly.
      coords = @id.split '-'
      col = parseInt coords[0]
      row = parseInt coords[1]

      type = @dataset.cellType
      walkable[row][col] = if type is "empty" then 0 else 1
