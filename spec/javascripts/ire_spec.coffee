describe "Ire", ->

  describe "Ire#constructor", ->
    it "gives Ire an initial movement range of 5", ->
      ire = new Ire
      expect(ire.range).toBe(5)

    it "gives Ire an initial HP of 20", ->
      ire = new Ire
      expect(ire.hp).toBe(20)

  # describe "Ire#increaseRange", ->
  #   it "increases Ire's range by 1", ->
  #     ire = new Ire
  #     ire.increaseRange
  #     expect(ire.range).toBe(6)
