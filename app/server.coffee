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

app.get('/:apikey/thing_likeiness', (req, res) ->

  things = {}
  getCollection req, res, (collection)->
    user = collection.getUser req.query["userID"]
    userArray = collection.findSimilarUsers user

    for u in userArray
      u = collection.getUser(u)
      for thingID,thing of u.ratedThings
        things[thingID] ?= 0
        for attr,score of thing
          things[thingID] += score


    #remove places that the user has visited before
    for thingID of user.ratedThings
      delete things[thingID]

    outArr = []
    for a of things
      outArr.push a

    outArr.sort((a,b) -> things[b]-things[a] )
    for thingID,i in outArr
      outArr[i] = collection.getThing(thingID).getAverage()
      outArr[i].placeName = thingID
    res.end 'p('+JSON.stringify(outArr)+')'
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

