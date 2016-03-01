var Users = require('../models/Users');

var generateToken = function() {
  return String(Math.floor(Math.random()*9000) + 1000);
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
  auth: function(req, res) {
    var newToken = generateToken();
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
            console.log(newToken);
            res.send({
              _id: doc._id,
              snapname: doc.snapname,
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
            console.log(newToken);
            res.send({
              _id: docs._id,
              snapname: docs.snapname,
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
  // req.body = snapname and submittedToken
  login: function(req, res) {
    var snapname = req.body.snapname;
    var submittedCode = req.body.submittedCode;
    Users.findOne({
      snapname: snapname
    }, function(err, docs) {
      var realToken = docs.accessToken;
      if(!err) {
        if(submittedCode == realToken) {
          res.status(200).send(docs);
        }
        else {
          res.status(400).send("Rejected");
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
  }
}