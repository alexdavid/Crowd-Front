

class exports.User

  constructor: (id) ->
    @attr = {}


  rate: (thingID, attrs) ->
    return -1 unless thingID?
    return -1 unless typeof attrs is "object"

    for attrName,score of attrs
      @attr[attrName] ?= []
      @attr[attrName][score] ?= []
      @attr[attrName][score].push thingID

    0
