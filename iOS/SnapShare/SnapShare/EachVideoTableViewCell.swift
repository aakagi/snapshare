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
    
    var video: NSURL? {
        didSet {
            updateUI()
        }
    }
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @IBOutlet weak var playToggle: UIButton!
    @IBOutlet weak var plusThree: UIButton!
    @IBOutlet weak var tempButton: UIButton!
    
    func updateUI() {
        
        let url = video!
        playerItem = AVPlayerItem(URL: url)
        player = AVPlayer(playerItem: playerItem!)
        playerLayer = AVPlayerLayer(player: player!)
        
        playerLayer!.frame = CGRectMake(0,20,self.frame.width,self.frame.height / 1.6)
        self.layer.addSublayer(playerLayer!)
        
        playToggle.addTarget(self, action: "playButtonTapped:", forControlEvents: .TouchUpInside)
        
        plusThree.addTarget(self, action: "ffThreeSeconds:", forControlEvents: .TouchUpInside)
        
        tempButton.addTarget(self, action: "httpReq:", forControlEvents: .TouchUpInside)
        
    }
    
    func playButtonTapped(sender: AnyObject) {
        if player?.rate == 0 {
            player!.play()
            playToggle.setTitle("Pause", forState: UIControlState.Normal)
        }
        else {
            player!.pause()
            playToggle.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
    // THIS FUNCTION BARELY WORKS - YOU CAN'T SPAM THE +3 BUTTON, ALSO SHOULD BE MORE OO
    func ffThreeSeconds(sender: AnyObject) {
        let addTime = CMTimeMake(3, 1)
        player!.seekToTime(player!.currentTime() + addTime)
    }
    
    func httpReq(sender: AnyObject) {
        let url = NSURL(string: "http://localhost:8000/test")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, res, err) in
            
            if data != nil {
//                print(String(data: data!, encoding: NSUTF8StringEncoding)!)
                
                
//                let jsonRes: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                
//                print("AsSynchronous\(jsonRes)")
            }
            
            if res != nil {
                print(res!)
            }
            
        }
        
        task.resume()
        
        
        
        
        
    }
    
    
    
    
}
