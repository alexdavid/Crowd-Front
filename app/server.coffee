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

  getCollection req, res, (collection)->
    thingID = req.body.thingID
    userID = req.body.userID
    attr = req.body.attr
    res.end collection.rate userID, thingID, attr
)

app.get('/:apikey/rate', (req, res) ->

  getCollection req, res, (collection)->
    req.body = JSON.parse(req.query["data"])
    thingID = req.body.thingID
    userID = req.body.userID
    attr = req.body.attr
    res.end 'p("'+collection.rate(userID, thingID, attr).replace(/\n/g," ")+'")'
)


app.post('/:apikey/user_likeiness', (req, res) ->

  getCollection req, res, (collection)->
    user = collection.getUser req.body.userID
    userArray = collection.findSimilarUsers user
    res.end(JSON.stringify(userArray))
)

app.get('/:apikey/user_likeiness', (req, res) ->

  getCollection req, res, (collection)->
    user = collection.getUser req.query["userID"]
    userArray = collection.findSimilarUsers user
    res.end("p(#{JSON.stringify(userArray)})")
)

app.listen parseInt process.env.PORT

############################################

getCollection = (req, res, cb) ->
  collection = apiKeys[req.params.apikey]
  unless collection?
    res.end "INVALID API KEY"
    return
  cb collection

