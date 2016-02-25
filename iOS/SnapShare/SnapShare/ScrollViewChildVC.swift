//
//  ScrollViewChildVC.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/19/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class ScrollViewChildVC: UIViewController, UINavigationBarDelegate {

    var parentScrollView: UIScrollView?
    var leftButtonString: String?
    var rightButtonString: String?
    
    var childViewController: UIViewController?
    
//    var loggedInUser: User?
    
    // TODO - fix this it's a shit solution but it's all I have time for now
    var scrollChildType: String?
    
    
    let tempImage = UIImageView(frame: CGRectMake(80,120,200,200))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.view.addSubview(tempImage)
        
        // Header -> nav
        let navBar = NavScrollBar()
        navBar.leftButtonString = leftButtonString
        navBar.rightButtonString = rightButtonString
        navBar.parentVC = self
        self.view.addSubview(navBar)
        
        // Footer -> button
        let uploadButton = UploadButton()
        uploadButton.parentVC = self
        
        let childViewRect = CGRectMake(0, navBar.navHeight, screenWidth, screenHeight - uploadButton.buttonHeight)
        
        // Main content
        switch scrollChildType! {
        case "Settings":
            // TODO - Settings Page
            let settingsVC = UITableViewController()
            settingsVC.view.frame = childViewRect
            self.view.addSubview(settingsVC.view)
        case "Feed":
            let childVideoVC = VideoTableViewController()
            self.addChildViewController(childVideoVC)
            childVideoVC.didMoveToParentViewController(self)
            childVideoVC.view.frame = childViewRect
//            self.view.addSubview(childVideoVC.view)
            
            self.view.addSubview(uploadButton)
            
            
//            self.view.addSubview(uploadButton)
        case "User":
            let childVideoVC = UserVideosViewController()
            self.addChildViewController(childVideoVC)
            childVideoVC.didMoveToParentViewController(self)
            childVideoVC.view.frame = childViewRect
            self.view.addSubview(childVideoVC.view)
//            self.view.addSubview(uploadButton)
        default:
            print("NOPE FUCK YOU")
        }
    }
}
