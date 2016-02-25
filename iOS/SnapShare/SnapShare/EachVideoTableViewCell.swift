//
//  EachVideoTableViewCell.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit
import AVFoundation

class EachVideoTableViewCell: UITableViewCell {
    
    var videoObj: Video? {
        didSet {
            updateUI()
        }
    }
    
    var cellExpanded: Bool?
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var testAsset: AVAsset?
    
    func updateUI() {
        
        // Makes size of video player the exact size of an iphone camera in portrait mode
        let screenWidth = UIScreen.mainScreen().bounds.width
        let videoSizeRect = CGRectMake(screenWidth * 7/32, 0, screenWidth * 18/32, screenWidth)

        // Create video player
        let url = NSURL(string: videoObj!.videoUrl)
        playerItem = AVPlayerItem(URL: url!)
        
//        playerItem = AVPlayerItem(asset: testAsset!)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!)
        playerLayer!.frame = videoSizeRect
        
        // Make an overlay that acts as a play toggle button when you tap on the video
        let playToggleView = UIView(frame: videoSizeRect)
        let tap = UITapGestureRecognizer(target: self, action: Selector("togglePlay:"))
        tap.delegate = self
        playToggleView.addGestureRecognizer(tap)
        
        // TODO - Add username overlay somewhere
        
        // TODO - Make major key button
        
        // TODO - Make fast forward 3 seconds button
        
        
        
        // Add shit to the cell
        self.clipsToBounds = true
        self.layer.addSublayer(playerLayer!)
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 0.5
        self.addSubview(playToggleView)

    }

    func togglePlay(sender: AnyObject) {
//        if cellExpanded == false {
//            UIView.animateWithDuration(0.1, animations: {() in
//                var cellFrame: CGRect = self.bounds
//                cellFrame.size.height = self.bounds.width
//                self.bounds = cellFrame
//                
//                let tableSuperview = self.superview
//                var tableSuperviewFrame: CGRect = tableSuperview!.bounds
//                print(tableSuperviewFrame.size.height)
//                tableSuperviewFrame.size.height += self.bounds.width
//                print(tableSuperviewFrame.size.height)
//                self.superview!.bounds = tableSuperviewFrame
//
//            })
//            cellExpanded = true
//        }
        if player?.rate == 0 {
            player!.play()
        }
        else {
            player!.pause()
        }
    }
}
// THIS FUNCTION BARELY WORKS - YOU CAN'T SPAM THE +3 BUTTON, ALSO SHOULD BE MORE OO
//    func ffThreeSeconds(sender: AnyObject) {
//        let addTime = CMTimeMake(3, 1)
//        player!.seekToTime(player!.currentTime() + addTime)
//    }


    
    

