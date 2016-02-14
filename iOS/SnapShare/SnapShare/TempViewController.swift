//
//  TempViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit
import AVFoundation

class TempViewController: UIViewController {
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

    @IBOutlet weak var playToggle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = NSURL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        
        
        
        let url = NSURL(string: "http://www.akagi.co/video/snapstory1.m4v")
        
        playerItem = AVPlayerItem(URL: url!)
        player = AVPlayer(playerItem: playerItem!)
        
        playerLayer = AVPlayerLayer(player: player!)
        playerLayer!.frame = CGRectMake(0,50,self.view.frame.size.width,200)
        self.view.layer.addSublayer(playerLayer!)
        playToggle.addTarget(self, action: "playButtonTapped:", forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "finishedPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func finishedPlaying(notification: NSNotification) {
        playToggle.setTitle("Play", forState: UIControlState.Normal)
        let endOfStream: AVPlayerItem = notification.object as! AVPlayerItem
        endOfStream.seekToTime(kCMTimeZero)
        
    }

    
}
