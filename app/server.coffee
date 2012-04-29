EXPRESS = require('express')
Collection = require('./collection').Collection
User = require('./users').User


apiKeys = {}
apiKeys['test'] = new Collection()


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
  things = user.ratedThings

  similarUsers = {}
  for thing in things
    a
  
  res.end()
)



app.listen parseInt process.env.PORT
