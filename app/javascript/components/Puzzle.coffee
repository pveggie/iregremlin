import React from "react"
import PropTypes from "prop-types"

class Puzzle extends React.Component
  # @PropTypes {

  # }

  constructor: (props)->
    super props
    @state =
      health: 15
      weapon: null
      enemies: 3
    #console.log @state

  render: ->
    "Test"

export default Puzzle
