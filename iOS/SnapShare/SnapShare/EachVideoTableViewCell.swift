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
    
//    var testButton: UIButton?
    
    @IBOutlet weak var playToggle: UIButton!
    
    func updateUI() {
        
        let url = video!
        playerItem = AVPlayerItem(URL: url)
        player = AVPlayer(playerItem: playerItem!)
        
        playerLayer = AVPlayerLayer(player: player!)
        
        print(player!)
        
        
        playerLayer!.frame = CGRectMake(0,0,self.frame.width,self.frame.height)
        self.layer.addSublayer(playerLayer!)
        
//        let button   = UIButton(type: UIButtonType.System) as UIButton
//        button.frame = CGRectMake(100, 100, 100, 50)
//        button.setTitle("Test Button", forState: UIControlState.Normal)
//        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        self.addSubview(button)
        
        
//        let tempRect = CGRect(x: 0, y: 0, width: 50, height: 50)
//        testButton = UIButton(frame: tempRect)
//        testButton?.setTitle("ayeee", forState: UIControlState.Normal)
//        testButton?.backgroundColor = UIColor.redColor()
        
        playToggle.addTarget(self, action: "playButtonTapped:", forControlEvents: .TouchUpInside)
        
    }
    
    func playButtonTapped(sender: AnyObject) {
        if player?.rate == 0 {
            player!.play()
            playToggle.setTitle("Pause", forState: UIControlState.Normal)
            print(video)
        }
        else {
            player!.pause()
            playToggle.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
}
