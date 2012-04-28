
User = require('./users.coffee').User

class exports.Collection

  constructor: () ->
    @users = {}


  getUser: (id) ->
    user = @users[id]
    return user if user?
    @users[id] = new User(id)
