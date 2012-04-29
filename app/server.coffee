EXPRESS = require('express')
Collection = require('./collection').Collection
User = require('./users').User


apiKeys = {}
apiKeys['test'] = new Collection()
apiKeys['recommendla'] = new Collection()


app = EXPRESS.createServer()
app.use(EXPRESS.bodyParser())


app.get('/', (req, res) ->
  res.end "Welcome to CrowdFront"
)

app.get('/example', (req, res) ->
  res.send require('./html').submitRating
  res.end 200, { 'Content-Type': 'text/html' }
)

app.post('/:apikey/rate', (req, res) ->
  thingID = req.body.thingID
  userID = req.body.userID
  attr = req.body.attr

  collection = apiKeys[req.params.apikey]

  unless collection?
    res.end "INVALID API KEY"
    return

  user = collection.getUser(userID)
  thing = collection.getThing(thingID)
  out = user.rate thingID, attr
  out += "\n"
  out += thing.rate userID, attr
  res.end out
)


app.post('/:apikey/user_likeiness', (req, res) ->
  userID = req.body.userID

  collection = apiKeys[req.params.apikey]

  unless collection?
    res.end "INVALID API KEY"
    return

  user = collection.getUser userID
  
  userArray = findSimilarUsers user, collection
  res.end(JSON.stringify(userArray))
)

app.get('/:apikey/user_likeiness', (req, res) ->
  userID = req.query["userID"]

  collection = apiKeys[req.params.apikey]

  unless collection?
    res.end "INVALID API KEY"
    return

  user = collection.getUser userID
  
  userArray = findSimilarUsers user, collection
  res.end("p(#{JSON.stringify(userArray)})")
)


findSimilarUsers = (user, collection) ->
  things = user.ratedThings

  similarUsers = {}

  for thingID,attrs of things
    thing = collection.getThing(thingID)

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


app.listen parseInt process.env.PORT
