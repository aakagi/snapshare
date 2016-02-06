/*

    This is the base server file

    The server will handle:
    1) User & Video models
    2) Writing to the DB
    3) User authentication

*/
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

var port = process.env.PORT || 8000;
app.use(bodyParser.json());

require('dotenv').load();

var apiKey = process.env.API_KEY || 'Token apikey';

// controllers
var userController = require('./controllers/userController');
var videoController = require('./controllers/videoController');

var mongoUri = process.env.MONGO_URI || 'mongodb://localhost:12345/snapshare';
mongoose.connect(mongoUri);


mongoose.connection.on('error', function() {
  console.log('MongoDB Connection Error. Please make sure that MongoDB is running.');
  process.exit(1);
});

// Verify API token
app.use('/', function(req, res, next) {
  var attemptedKey = req.headers.authorization;
  if (attemptedKey === apiKey) {
    next();
  } else {
    res.status(401).send("Incorrect API Key");
  }
});

// User management
app.post('/user/login', userController.login); // login & for account creation
app.post('/user/auth', userController.auth); // auth password
app.get('/user/logout', userController.logout); // log out
app.post('/user/scrname', userController.scrname); // update screen name
// User video routes
app.get('/videos/user', videoController.getUserVideos); // get my videos
app.post('/videos/user', videoController.postVideo); // post or update video
app.delete('/videos/user', videoController.deleteVideo); // delete video
// Not related to active user
app.get('/videos/top', videoController.getTopVideos); // get top videos
app.get('/videos/new', videoController.getNewVideos); // get all videos
app.get('/videos/:selecteduser', videoController.getSelectedUserVideos); // get all videos of selected user
// Routes to eventually populate
// app.delete('/user')

app.listen(port);
console.log('Listening to port: ' + port);