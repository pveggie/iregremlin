class @PuzzleMap
  # get size of grid and create blank matrix array
  constructor: ->
    numRows = Math.sqrt $('td').length
    # Assuming all maps are square
    @matrix = new Array(numRows)
    for num in [0...numRows]
      @matrix[num] = new Array(numRows)

  # update grid to reflect walkable and non-walkable cells
  updateMatrix: ->
    # Define matrix for use in iterator becuase in the iterator
    # 'this/@' is the td rather than the puzzle object
    matrix = @matrix

    $('td').each ->
      # td objects are different from the ones obtained with class
      # selectors. They don't respond to attr method, but instead
      # id can be called directly.
      coords = @id.split '-'
      col = parseInt coords[0]
      row = parseInt coords[1]

      type = @dataset.cellType
      matrix[row][col] = if type is "empty" then 0 else 1

