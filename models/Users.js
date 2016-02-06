require('dotenv').load();
var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var userSchema = new Schema({
  snapName: String,
  name: String,
  accessToken: String,
  joined: Date,
  picture: String //URL of image on Amazon S3 - Snapcode or blank
});

var Users = mongoose.model('users', userSchema);
module.exports = Users;