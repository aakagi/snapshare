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
    
}
