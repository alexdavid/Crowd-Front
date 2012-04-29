

class exports.Thing


  constructor: ->
    @attr = {}



  rate: (userID, attrs) ->
    return "MISSING userID" unless userID?
    return "MISSING attr" unless typeof attrs is "object"

    for attrName,score of attrs
      @attr[attrName] ?= []
      @attr[attrName][score] ?= []
      @attr[attrName][score].push userID

    "Success"
