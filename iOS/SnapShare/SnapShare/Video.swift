//
//  Videos.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import Foundation

struct Video {
    
    let user: String
    let videoUrl: String
    let plays: Int
    let likes: Int
//    let posted: [NSDate]
    let reported: Int
    
    static func uploadToS3() {
        print("uploadSnapstory")
    }
    
    static func getTopVideos(count: Int, result: (videoArray: [Video], error: String?) -> Void) {
        let videoArray = [
            Video(user: "alexakagi", videoUrl: "http://www.akagi.co/video/video1.m4v", plays: 310, likes: 42, reported: 0),
            Video(user: "leokeisuke", videoUrl: "http://www.akagi.co/video/video2.m4v", plays: 211, likes: 32, reported: 0),
            Video(user: "somedude", videoUrl: "http://www.akagi.co/video/video3.m4v", plays: 112, likes: 22, reported: 0),
        ]
        
        result(videoArray: videoArray, error: "todo")
        
    }
    
    
}