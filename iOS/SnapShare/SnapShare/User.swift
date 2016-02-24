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
    let authCode: String
    let name: String
//    let joined: NSDate
//    let pictureUrl: String
    
    // Once this func is called, you can retrieve the resulting User and Error (string right now) from result:
    static func login(snapname: String, submittedCode: String, result: (User?,String?) -> Void) {
        
        // Get HttpHelper class
        let httpHelper = HttpHelper()
        // Create POST request to /user/auth
        let httpRequest = httpHelper.buildJsonRequest("user/login", method: "POST")
        // With body {snapname: snapname} JSON
        let jsonBody = "{\"snapname\":\"\(snapname)\",\"submittedCode\":\"\(submittedCode)\"}"
        // Attach JSON
        httpRequest.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Send request
        var resDataString: String?
        let task = NSURLSession.sharedSession().dataTaskWithRequest(httpRequest) {(data, res, err) in
            
            if err != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    result(nil,"error making http request")
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                if let httpResponse = res as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        // Convert result data to string
                        resDataString = String(data: data!, encoding: NSUTF8StringEncoding)!
                        // Make that into a dictionary
                        let resDictionary = httpHelper.convertJsonStringToDictionary(resDataString!)
                        // Get the parts of the dictionary and assign them to variables
                        let userSnapname = "\(resDictionary!["snapname"]!)"
                        let userAuthCode = "\(resDictionary!["accessToken"]!)"
                        let userName = "\(resDictionary!["name"]!)"
                        let userResult = User(snapname: userSnapname, authCode: userAuthCode, name: userName)
                        
                        result(userResult,nil)
                    }
                    else {
                        result(nil,"Invalid code. Go back if you need another code!")
                    }
                }
               
            }
        }
        task.resume()
        
    }
}