
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
