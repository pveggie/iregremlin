#= require calculator
describe "Calculator", ->

  it "should add two numbers", ->
    expect( new Calculator().add(2,2) ).toBe(4)
