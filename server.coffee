EXPRESS = require('express')
Collection = require('./collection').Collection
User = require('./users').User


apiKeys = {}
apiKeys['test'] = new Collection()


app = EXPRESS.createServer()


app.get('/', (req, res) ->
  res.end "Welcome to CrowdFront"
)

app.get('/:apikey/rate', (req, res) ->
  thingID = 1
  userID = 1
  attr = {}

  collection = apiKeys[req.params.apikey]

  unless collection?
    res.end "INVALID API KEY"
    return

  user = collection.getUser(userID)
  res.end ""+user.rate thingID, attr
)


app.listen process.env.PORT
