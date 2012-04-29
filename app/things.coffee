

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


  getAverage: ->
    out = {}
    for attrName,arr of @attr
      sum = 0
      out[attrName] = 0
      for q,i in arr
        m = q?.length
        m = 0 unless m?
        out[attrName] += i*m
        sum += m
      out[attrName] /= sum

    out
