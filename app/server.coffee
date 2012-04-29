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

  unless userID?
    res.end "MISSING userID"
    return

  collection = apiKeys[req.params.apikey]

  unless collection?
    res.end "INVALID API KEY"
    return

  user = collection.getUser(userID)
  res.end user.rate thingID, attr
)


app.post('/:apikey/user_likeiness', (req, res) ->
  res.end()
)



app.listen parseInt process.env.PORT
