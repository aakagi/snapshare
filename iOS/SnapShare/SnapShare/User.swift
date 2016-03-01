//
//  User.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct User {
    
    let _id: String
    let snapname: String
    let authCode: String
    let name: String
//    let joined: NSDate
//    let pictureUrl: String
    
    // Once this func is called, you can retrieve the resulting User and Error (string right now) from result:
    static func login(snapname: String, submittedCode: String, result: (User?,String?) -> Void) {

        // Create POST request to /user/auth with body {snapname: snapname}
        let jsonBody = "{\"snapname\":\"\(snapname)\",\"submittedCode\":\"\(submittedCode)\"}"
        let httpRequest = HttpHelper.buildJsonRequest("/user/login", method: "POST", jsonBody: jsonBody)
       
        // Send request
        HttpHelper.sendRequest(httpRequest) { (err, res) in
            if res != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    let userId = "\(res!["_id"]!)"
                    let userSnapname = "\(res!["snapname"]!)"
                    let userAuthCode = "\(res!["accessToken"]!)"
                    let userName = "\(res!["name"]!)"
                    let userResult = User(_id: userId, snapname: userSnapname, authCode: userAuthCode, name: userName)
                    
                    result(userResult,nil)
                }
            }
            else {
                result(nil,"Invalid code. Go back if you need another code!")
            }
            
        }
    }
    
}