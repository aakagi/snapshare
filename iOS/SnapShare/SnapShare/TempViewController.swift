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

    @IBOutlet weak var playToggle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3"))
        playerItem = AVPlayerItem(URL: url!)
        player = AVPlayer(playerItem: playerItem!)
        
        let playerLayer
        
        
        
    }
    
    
    
}
