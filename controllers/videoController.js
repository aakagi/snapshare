var Videos = require('../models/Videos');

var makeTimeStamp = function() {
  var d = new Date()
  // Only care about minute accuracy
  return Math.floor(d.getTime() / 6000)
}

var generateVideoUrl = function(userId) {
  var timeString = String(makeTimeStamp())
  var urlBase = "https://s3-us-west-1.amazonaws.com/majorkey-assets/"
  return urlBase + userId + "-" + timeString + ".m4v";
}

module.exports = {
  // req.body = userId
  getUserVideos: function(req, res) {
    var userId = req.body.userId;
    Videos.find({
      user: userId
    });
  },
  // req.body = userId, snapname
  postVideo: function(req, res) {
    var userId = req.body.userId;
    var snapname = req.body.snapname;
    var videoUrl = generateVideoUrl(userId)

    // See if there are any videos posted within the last 6 hours
    Videos.findOne({
      created: {
        $gt: makeTimeStamp() - 360
      }
    }, function(err, doc) {
      if(doc) {
        res.send("Too early")
      }
      else if (!err) {
        // Create a new video if a video doesn't already exist
        Videos.create({
          userId: userId,
          userSnapname: snapname,
          created: makeTimeStamp(),
          videoUrl: videoUrl,
          views: 0,
          likes: 0,
          reported: 0
        }, function(err, docs) {
          if(!err) {
            res.send(docs);
          }
          else {
            res.status(500).send(err);
          }
        });
      }
      else {
        res.status(500).send(err);
      }
    })
  },
  // req.body = userId, snapname
  updateVideo: function(req, res) {
    var userId = req.body.userId;
    var snapname = req.body.snapname;

    // TODO

  },
  // req.body = videoId
  deleteVideo: function(req, res) {
    var videoId = req.body.videoId;
    Videos.remove({
      _id: videoId
    }, function(err) {
      if (err) {
        res.status(500).send(err);
      }
    });
  },
  getTopVideos: function(req, res) {
    // Get first 10 videos, sorted by most likes (should make a method for it)
    // Videos.find()

  },
  getNewVideos: function(req, res) {
    // Get the first 10 videos, sorted by most recent date (should make a method for it)
  },
  // req.body = userId
  getSelectedUserVideos: function(req, res) {
    // Limit to most recent 10
    var userId = req.body.userId;
    Vidos.find({
      user: userId
    });
  }
}