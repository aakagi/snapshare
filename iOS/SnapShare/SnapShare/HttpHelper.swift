//
//  HttpHelper.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/15/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct HttpHelper {
    static let API_AUTH_NAME = ApiKeys.authName
    static let API_AUTH_PASSWORD = ApiKeys.authPassword
    static let BASE_URL = ApiKeys.authBaseUrl
    static let API_AUTH_TOKEN = ApiKeys.apiAuthToken

    func buildJsonRequest(path: String!, method: String!) -> NSMutableURLRequest {
            
        // Create the request URL from path
        let requestURL = NSURL(string: "\(HttpHelper.BASE_URL)/\(path)")
        let request = NSMutableURLRequest(URL: requestURL!)
        // Set HTTP request method
        request.HTTPMethod = method
        // Set Content-Type to json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Set Auth Token
        request.addValue("Token \(HttpHelper.API_AUTH_TOKEN)", forHTTPHeaderField: "Authorization")
            
        return request
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    

//    func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> () {
//        // Create a NSURLSession task
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) {(data, res, err) in
//            
//            if err != nil {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    
//                })
//                
//                return
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                completion(data, nil)
//            })
////            if data != nil {
////                print(String(data: data!, encoding: NSUTF8StringEncoding)!)
////            }
//        }
//        task.resume()
//    }
//
//    func uploadRequest(path: String, data: NSData, title: String) -> NSMutableURLRequest {
//        let boundary = "---------------------------14737809831466499882746641449"
//        var request = buildRequest(path, method: "POST", authType: HTTPRequestAuthType.HTTPTokenAuth,
//            requestContentType:HTTPRequestContentType.HTTPMultipartContent, requestBoundary:boundary) as NSMutableURLRequest
//        
//        let bodyParams : NSMutableData = NSMutableData()
//        
//        // build and format HTTP body with data
//        // prepare for multipart form uplaod
//        
//        let boundaryString = "--\(boundary)\r\n"
//        let boundaryData = boundaryString.dataUsingEncoding(NSUTF8StringEncoding) as NSData!
//        bodyParams.appendData(boundaryData)
//        
//        // set the parameter name
//        let imageMeteData = "Content-Disposition: attachment; name=\"image\"; filename=\"photo\"\r\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(imageMeteData!)
//        
//        // set the content type
//        let fileContentType = "Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(fileContentType!)
//        
//        // add the actual image data
//        bodyParams.appendData(data)
//        
//        let imageDataEnding = "\r\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(imageDataEnding!)
//        
//        let boundaryString2 = "--\(boundary)\r\n"
//        let boundaryData2 = boundaryString.dataUsingEncoding(NSUTF8StringEncoding) as NSData!
//        
//        bodyParams.appendData(boundaryData2)
//        
//        // pass the caption of the image
//        let formData = "Content-Disposition: form-data; name=\"title\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(formData!)
//        
//        let formData2 = title.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(formData2!)
//        
//        let closingFormData = "\r\n".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//        bodyParams.appendData(closingFormData!)
//        
//        let closingData = "--\(boundary)--\r\n"
//        let boundaryDataEnd = closingData.dataUsingEncoding(NSUTF8StringEncoding) as NSData!
//        
//        bodyParams.appendData(boundaryDataEnd)
//        
//        request.HTTPBody = bodyParams
//        return request
//    }
//    
//    func getErrorMessage(error: NSError) -> NSString {
//        var errorMessage : NSString
//        
//        // return correct error message
//        if error.domain == "HTTPHelperError" {
//            let userInfo = error.userInfo as NSDictionary!
//            errorMessage = userInfo.valueForKey("message") as! NSString
//        } else {
//            errorMessage = error.description
//        }
//        
//        return errorMessage
//    }
}
