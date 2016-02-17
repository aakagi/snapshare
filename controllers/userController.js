var Users = require('../models/Users');

var generateToken = function() {
  return String(Math.floor(Math.random()*10000));
}

// How do I use this?
var userTokenCB = function(err) {
  if(!err) {
    // sendCode(newToken);
    res.send(newToken);
  }
  else {
    res.status(500).send(err);
  }
}

module.exports = {
  // User login - if account doesn't exist, creates new user
  login: function(req, res) {
    var newToken = generateToken();

    console.log(req.body.snapname);

    // First checks to see if user exists
    Users.findOne({
      snapname: req.body.snapname
    }, function(err, doc) {
      if(doc) {
        var doc = doc;
        Users.update({
          _id: doc._id
        }, {
          accessToken: newToken
        }, function(err) {
          if(!err) {
            // sendCode(newToken);
            res.send({
              _id: doc._id,
              accessToken: newToken
            });
          }
          else {
            res.status(500).send(err);
          }
        });
      }
      else if(err) {
        res.status(500).send(err);
      }
      else {
        // Creates new user if user doesn't exist
        Users.create({
          snapname: req.body.snapname,
          name: "",
          accessToken: newToken,
          joined: new Date(),
          picture: "String" //URL of image on Amazon S3 - Snapcode or blank
        }, function(err, docs) {
          if(!err) {
            // sendCode(newToken);
            res.send({
              _id: docs._id,
              accessToken: newToken
            });
          }
          else {
            res.status(500).send(err);
          }
        });
      }
    });

  },
  // req.body = userId and accessToken
  auth: function(req, res) {
    var userId = req.body.userId;
    Users.findOne({
      _id: userId
    }, function(err, docs) {
      var realToken = docs.accessToken;
      var attemptedToken = req.body.accessToken;
      if(!err) {
        if(attemptedToken == realToken) {
          res.send("You're a real user yay");
        }
        else {
          res.send("Rejected");
        }
      }
      else {
        res.status(500).send(err);
      }
    });
  },
  logout: function(req, res) {
    res.send("TODO");
  },
  // req.body = userId and scrname
  scrname: function(req, res) {
    var userId = req.body.userId;
    var scrname = req.body.scrname;
    Users.update({
      _id: userId
    }, {
      scrname: scrname
    }, function(err, result) {
      if(!err) {
        res.send(result);
      }
      else {
        res.status(500).send(err);
      }
    });
  },
  test: function(req, res) {
    console.log(req);
    res.send("received");
  }

}