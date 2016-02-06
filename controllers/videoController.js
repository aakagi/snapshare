var Videos = require('../models/Videos');

module.exports = {
  // req.body = userId
  getUserVideos: function(req, res) {
    var userId = req.body.userId;
    Videos.find({
      user: userId
    });
  },
  // req.body = userId, videoUrl
  postVideo: function(req, res) {
    var userId = req.body.userId;
    var videoUrl = req.body.videoUrl;
    Videos.create({
      user: userId,
      created: [new Date()],
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