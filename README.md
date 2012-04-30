Crowd-Front
===========
http://crowdfront.net


Our submission to the #CityGridHackathonLA.

CrowdFront is an API to match users with similar tastes and recommend things to other users generically. It was hacked together in a weekend; the source is a mess.


## Example Usage:
POST to /APIKEY/rate

```
{
  userID: "user1",
  thingID: "Some restaurant",
  attr:{
    "food": 4,
    "price": 3
  }
}
```
attr object is completely dynamic, you can supply any attributes and any score ranges you want.

### After users have rated things:
GET or POST to /APIKEY/user_likeiness with userID to get an array of similar users in order of compatibility.
GET or POST to /APIKEY/thing_likeiness with userID to get an array of things that user may like with average attributes rated from similar users.


Visit http://crowdfront.net/example to demo app functionality. Use the APIKey "test"

