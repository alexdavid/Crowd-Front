
User = require('./users').User
Thing = require('./things').Thing

class exports.Collection

  constructor: () ->
    @users = {}
    @things = {}


  getUser: (id) ->
    user = @users[id]
    return user if user?
    @users[id] = new User(id)

  getThing: (id) ->
    thing = @things[id]
    return thing if thing?
    @things[id] = new Thing(id)


  findSimilarUsers: (user) ->
    things = user.ratedThings

    similarUsers = {}

    for thingID,attrs of things
      thing = @getThing(thingID)

      for attribute,score of attrs
        score = parseInt score
        users = thing.attr[attribute][score]
        usersl = thing.attr[attribute][score-1]
        usersg = thing.attr[attribute][score+1]
        usersl ?= []
        usersg ?= []

        for tmp in users
          similarUsers[tmp] ?= 0
          similarUsers[tmp]+=2
        for tmp in usersl
          similarUsers[tmp] ?= 0
          similarUsers[tmp]++
        for tmp in usersg
          similarUsers[tmp] ?= 0
          similarUsers[tmp]++

    delete similarUsers[user.id]
    outArr = []
    for user of similarUsers
      outArr.push user

    outArr.sort((a,b) -> similarUsers[b]-similarUsers[a] )


  rate: (userID, thingID, attr) ->
    user = @getUser(userID)
    thing = @getThing(thingID)
    out = user.rate thingID, attr
    out += "\n"
    out += thing.rate userID, attr
