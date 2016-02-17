//
//  User.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct User {

    let snapname: String
    let userId: String
    let authCode: String
    let name: String
//    let joined: NSDate
    let pictureUrl: String
    
    static func login(snapname: String, submittedCode: String) -> User? {
        if let user = database[snapname] {
            if user.authCode == submittedCode {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(snapname: "alexakagi", userId: "56b5b3d16e0431cb571f5a70", authCode: "1234", name: "Alex Akagi", pictureUrl: "http://www.akagi.co/images/profile.jpg"),
            User(snapname: "something", userId: "56b5b3d16e0431cb571f5a71", authCode: "1234", name: "Madison Bumgarner", pictureUrl: "http://www.akagi.co/images/profile.jpg"),
            User(snapname: "leokeisuke", userId: "56b5b3d16e0431cb571f5a72", authCode: "1234", name: "Leo Akagi", pictureUrl: "http://www.akagi.co/images/profile.jpg")
            ] {
                theDatabase[user.snapname] = user
        }
        return theDatabase
    }()
}