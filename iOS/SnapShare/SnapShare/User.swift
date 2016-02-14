//
//  User.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let username: String
    let password: String
    
    static func login(username: String, password: String) -> User?{
        if let user = database[username] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "one dude", username: "dudeone", password: "asdf"),
            User(name: "two dude", username: "dudetwo", password: "asdf")
            ] {
                theDatabase[user.username] = user
        }
        return theDatabase
    } ()
}