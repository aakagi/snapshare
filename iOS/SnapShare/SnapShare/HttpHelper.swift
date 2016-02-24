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
    
    func buildJsonRequest(path: String!, method: String!) -> NSMutableURLRequest {
            
        // Create the request URL from path
        let requestURL = NSURL(string: "\(HttpHelper.SERVER_AUTH_BASE_URL)/\(path)")
        let request = NSMutableURLRequest(URL: requestURL!)
        // Set HTTP request method
        request.HTTPMethod = method
        // Set Content-Type to json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Set Auth Token
        request.addValue("Token \(HttpHelper.SERVER_AUTH_API_TOKEN)", forHTTPHeaderField: "Authorization")
            
        return request
    }
    
    func convertJsonStringToDictionary(text: String) -> [String:AnyObject]? {
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
