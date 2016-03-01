//
//  Videos.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct Video {
    
    let userId: String
    let userSnapname: String
    let created: Int64
    let videoUrl: String
    let views: Int
    let likes: Int
    let reported: Int
    
    
    
    static func uploadVideo(currentUser: User, uploadRequest: AWSS3TransferManagerUploadRequest, result: () -> Void) {
        
//        userId: String,
//        userSnapname: String,
//        created: Number,
//        videoUrl: String,
//        views: Number,
//        likes: Number,
//        reported: Number
        
        
        let userId = currentUser._id
        let userSnapname = currentUser.snapname
        let created = Int(floor(NSDate().timeIntervalSince1970 / 60))
        print(created)
        
        uploadRequest.key = "\(userId)-\(created).m4v"
        uploadRequest.bucket = ApiKeys.S3BucketName

        let urlKey = uploadRequest.key!
        
        // Create new video object in DB
        let jsonBody = "{\"userId\":\"\(userId)\",\"userSnapname\":\"\(userSnapname)\",\"created\":\"\(created)\",\"urlKey\":\"\(urlKey)\"}"
        print(jsonBody)
        let httpRequest = HttpHelper.buildJsonRequest("/videos/user", method: "POST", jsonBody: jsonBody)
        
        
        HttpHelper.sendRequest(httpRequest, result: { (err, res) in
            
            if res != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let transferManager = AWSS3TransferManager.defaultS3TransferManager()
                    transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
                        
                        if let error = task.error {
                            if error.domain == AWSS3TransferManagerErrorDomain as String {
                                if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                                    switch (errorCode) {
                                    case .Cancelled, .Paused:
                                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                            
                                        })
                                        break;
                                        
                                    default:
                                        print("upload failed: [\(error)]")
                                        break;
                                    }
                                } else {
                                    print("upload failed: [\(error)]")
                                }
                            } else {
                                print("upload failed: [\(error)]")
                            }
                        }
                        
                        if let exception = task.exception {
                            print("upload failed: [\(exception)]")
                        }
                        
                        if task.result != nil {
                            dispatch_async(dispatch_get_main_queue(), { () in
                                
                                print("Success")
                                
                            })
                        }
                        return nil
                    }

                    
                    
                    
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue()) {
                    print("error making http request")
                }
            }
        })
        
        
        result()
    }
        

    
    
    static func fetchVideosFor(type: String, result: (videoArray: [Video], error: String?) -> Void) {
        
        
//        // Get HttpHelper class
//        let httpHelper = HttpHelper()
//        // Create POST request to /user/auth
//        let httpRequest = httpHelper.buildJsonRequest("user/login", method: "POST")
//        // With body {snapname: snapname} JSON
////        let jsonBody = "{\"snapname\":\"\(snapname)\",\"submittedCode\":\"\(submittedCode)\"}"
//        // Attach JSON
//        httpRequest.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        // Send request
//        var resDataString: String?
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(httpRequest) {(data, res, err) in
//            
//            var route: String
//            
//            switch type {
//            case "t":
//                print("top")
//                route = "top"
//            case "n":
//                print("new")
//                route = "new"
//            default:
//                print(type)
//                route = "user"
//            }
//            
//            if err != nil {
//                dispatch_async(dispatch_get_main_queue()) {
////                    result(nil,"error making http request")
//                }
//            }
//            
//            dispatch_async(dispatch_get_main_queue()) {
//                if let httpResponse = res as? NSHTTPURLResponse {
//                    if httpResponse.statusCode == 200 {
//                        // Convert result data to string
//                        resDataString = String(data: data!, encoding: NSUTF8StringEncoding)!
//                        // Make that into a dictionary
//                        let resDictionary = httpHelper.convertJsonStringToDictionary(resDataString!)
//                        // Get the parts of the dictionary and assign them to variables
//                        let userSnapname = "\(resDictionary!["snapname"]!)"
//                        let userAuthCode = "\(resDictionary!["accessToken"]!)"
//                        let userName = "\(resDictionary!["name"]!)"
//                        let userResult = User(snapname: userSnapname, authCode: userAuthCode, name: userName)
//                        
////                        result(userResult,nil)
//                    }
//                    else {
////                        result(nil,"Invalid code. Go back if you need another code!")
//                    }
//                }
//                
//            }
        
        
        let videoArray = [
            Video(userId: "56c3eaad6a920f64f39d34cd", userSnapname: "alexakagi", created: 242724129, videoUrl: "https://s3-us-west-1.amazonaws.com/majorkey-assets/video1.m4v", views: 310, likes: 42, reported: 0),
            Video(userId: "56c3eaad6a920f64f39d34cd", userSnapname: "alexakagi", created: 242724129, videoUrl: "https://s3-us-west-1.amazonaws.com/majorkey-assets/video2.m4v", views: 310, likes: 42, reported: 0),
            Video(userId: "56c3eaad6a920f64f39d34cd", userSnapname: "alexakagi", created: 242724129, videoUrl: "https://s3-us-west-1.amazonaws.com/majorkey-assets/video3.m4v", views: 310, likes: 42, reported: 0)
        ]
    
        result(videoArray: videoArray, error: "todo")
        
    }

//    static func uploadVideo(snapname: String, userId: String, result: (success: String?, error: String?) -> Void) {
//        
//        
//        // Get HttpHelper class
//        let httpHelper = HttpHelper()
//        // Create POST request to /user/auth
//        let httpRequest = httpHelper.buildJsonRequest("user/login", method: "POST")
//        // With body {snapname: snapname} JSON
//        let jsonBody = "{\"snapname\":\"\(snapname)\",\"submittedCode\":\"\(userId)\"}"
//        // Attach JSON
//        httpRequest.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
//        
//        // Send request
//        var resDataString: String?
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(httpRequest) {(data, res, err) in }
//
//        
//        
//    }
    
    
    
    
    
    
}