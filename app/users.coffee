

class exports.User

  constructor: ->
    @attr = {}
    @ratedThings = []


  rate: (thingID, attrs) ->
    return "MISSING thingID" unless thingID?
    return "MISSING attr" unless typeof attrs is "object"

    for attrName,score of attrs
      @attr[attrName] ?= []
      @attr[attrName][score] ?= []
      @attr[attrName][score].push thingID

    @ratedThings.push thingID

    "Success"


