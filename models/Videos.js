require('dotenv').load();
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var videoSchema = new Schema({

  userId: String,
  userSnapname: String,
  created: Number,
  videoUrl: String,
  views: Number,
  likes: Number,
  reported: Number

});

var Videos = mongoose.model('videos', videoSchema);
module.exports = Videos;