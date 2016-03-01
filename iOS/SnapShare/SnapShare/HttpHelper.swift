//
//  HttpHelper.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/15/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

enum HttpRequestAuthType {
    case HttpBasicAuth
    case HttpTokenAuth
}

enum HttpRequestContentType {
    case HttpJsonContent
    case HttpMultipartContent
}

enum HttpRequestTo {
    case MajorKeyServer
    case GoogleCloudStorage
}

struct HttpHelper {
    static let SERVER_AUTH_NAME = ApiKeys.serverAuthName
    static let SERVER_AUTH_API_TOKEN = ApiKeys.serverAuthPassword
    static let SERVER_AUTH_BASE_URL = ApiKeys.serverAuthBaseUrl
    
    static func buildJsonRequest(path: String!, method: String!, jsonBody: String?) -> NSMutableURLRequest {
            
        // Create the request URL from path
        let requestURL = NSURL(string: "\(HttpHelper.SERVER_AUTH_BASE_URL)\(path)")
        let request = NSMutableURLRequest(URL: requestURL!)
        // Set HTTP request method
        request.HTTPMethod = method
        // Set Content-Type to json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Set Auth Token
        request.addValue("Token \(HttpHelper.SERVER_AUTH_API_TOKEN)", forHTTPHeaderField: "Authorization")
        
        if jsonBody != nil {
            request.HTTPBody = jsonBody!.dataUsingEncoding(NSUTF8StringEncoding)
        }
            
        return request
    }
    
    static func sendRequest(request: NSMutableURLRequest, result: ( NSError?, [String:AnyObject]?) -> Void) {
        var resDataString: String?
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, res, err) in
            if err == nil {
                dispatch_async(dispatch_get_main_queue()) {
                    if let httpResponse = res as? NSHTTPURLResponse {
                        print(httpResponse.statusCode)
                        if httpResponse.statusCode == 200 {
                            resDataString = String(data: data!, encoding: NSUTF8StringEncoding)!
                            let resDictionary = HttpHelper.convertJsonStringToDictionary(resDataString!)
                            result(nil, resDictionary)
                            
                        }
                        else {
                            print(httpResponse)
                        }
                    }
                    else {
                        print(res)
                    }
                }
            }
            else {
                print("Error in HttpHelper: \(err)")
                result(err, nil)
            }
        }
        task.resume()
    }
    
    static func convertJsonStringToDictionary(text: String) -> [String:AnyObject]? {
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
}
