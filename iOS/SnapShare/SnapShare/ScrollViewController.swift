//
//  ScrollViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/19/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var baseScrollView: UIScrollView!
    var currentUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let sessionKey = userDefaults.dataForKey("userSessionKey")
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Create UIScrollView
        let scrollViewRect = CGRectMake(0, 0, screenWidth, screenHeight)
        self.baseScrollView = UIScrollView(frame: scrollViewRect)
        self.baseScrollView.delegate = self
        self.baseScrollView.backgroundColor = UIColor.blackColor()
        self.baseScrollView.pagingEnabled = true
        
        // Set contentsize of view to be 3 views wide
        self.baseScrollView.contentSize = CGSizeMake(screenWidth * 3, self.view.frame.height)
        self.baseScrollView.contentOffset = CGPoint(x: screenWidth, y: 0)
        
        self.view.addSubview(baseScrollView)
        
        
        
        
        // Settings Page
        let View1: UIViewController = UIViewController()
        self.addChildViewController(View1)
        View1.didMoveToParentViewController(self)
        
        let nav1 = NavScrollBar()
        nav1.rightButtonString = "Videos"
        nav1.parentScrollView = self.baseScrollView
        
        nav1.frame = CGRectMake(screenWidth * 0, 0, screenWidth, nav1.navHeight)
        View1.view.frame = CGRectMake(screenWidth * 0, nav1.navHeight, screenWidth, screenHeight)
        self.baseScrollView.addSubview(View1.view)
        self.baseScrollView.addSubview(nav1)
        
        
        // Main Video Feed
        let View2: VideoTableViewController = VideoTableViewController()
        self.addChildViewController(View2)
        View2.didMoveToParentViewController(self)
        
        let nav2 = NavScrollBar()
        nav2.leftButtonString = "Settings"
        nav2.rightButtonString = "User"
        nav2.parentScrollView = self.baseScrollView
        
        let button2 = UploadButton()
        button2.parentVC = View2
        button2.currentUser = self.currentUser
        
        
        nav2.frame = CGRectMake(screenWidth * 1, 0, screenWidth, nav2.navHeight)
        View2.view.frame = CGRectMake(screenWidth * 1, nav2.navHeight, screenWidth, screenHeight - button2.buttonHeight)
        button2.frame = CGRectMake(screenWidth * 1, screenHeight - button2.buttonHeight, screenWidth, button2.buttonHeight)
        
        self.baseScrollView.addSubview(nav2)
        self.baseScrollView.addSubview(View2.view)
        self.baseScrollView.addSubview(button2)
        
        // User Videos
        let View3: UserVideosViewController = UserVideosViewController()
        self.addChildViewController(View3)
        View3.didMoveToParentViewController(self)
        
        let nav3 = NavScrollBar()
        nav3.leftButtonString = "Videos"
        nav3.parentScrollView = self.baseScrollView
        
        let button3 = UploadButton()
        button3.parentVC = View3
        button3.currentUser = self.currentUser
        
        View3.view.frame = CGRectMake(self.view.frame.width * 2, 0, screenWidth, screenHeight)

        nav3.frame = CGRectMake(screenWidth * 2, 0, screenWidth, nav3.navHeight)
        View3.view.frame = CGRectMake(screenWidth * 2, nav3.navHeight, screenWidth, screenHeight - button3.buttonHeight)
        button3.frame = CGRectMake(screenWidth * 2, screenHeight - button3.buttonHeight, screenWidth, button3.buttonHeight)
        self.baseScrollView.addSubview(nav3)
        self.baseScrollView.addSubview(View3.view)
        self.baseScrollView.addSubview(button3)
    }

}
