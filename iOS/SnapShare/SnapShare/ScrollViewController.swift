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
    var loggedInUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let sessionKey = userDefaults.dataForKey("userSessionKey")
        print(loggedInUser!)
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Create UIScrollView
        let scrollViewRect = CGRectMake(0, 0, screenWidth, screenHeight)
        self.baseScrollView = UIScrollView(frame: scrollViewRect)
        self.baseScrollView.delegate = self
        self.baseScrollView.backgroundColor = UIColor.blackColor()
        self.baseScrollView.pagingEnabled = true
        
        self.view.addSubview(baseScrollView)
        
        // Initialize the three VCs
        let View1: ScrollViewChildVC = ScrollViewChildVC()
        let View2: ScrollViewChildVC = ScrollViewChildVC()
        let View3: ScrollViewChildVC = ScrollViewChildVC()
        self.addChildViewController(View1)
        self.addChildViewController(View2)
        self.addChildViewController(View3)
        View1.didMoveToParentViewController(self)
        View2.didMoveToParentViewController(self)
        View3.didMoveToParentViewController(self)
        
        // Nav bar items
        View1.rightButtonString = "Videos"
        View2.leftButtonString = "Settings"
        View2.rightButtonString = "User"
        View3.leftButtonString = "Videos"
        
        // Temporary solution because I suck at OO programming
        View1.scrollChildType = "Settings"
        View2.scrollChildType = "Feed"
        View3.scrollChildType = "User"
        
        // Set frames for the three VCs
        View1.view.frame = CGRectMake(self.view.frame.width * 0, 0, screenWidth, screenHeight)
        View2.view.frame = CGRectMake(self.view.frame.width * 1, 0, screenWidth, screenHeight)
        View3.view.frame = CGRectMake(self.view.frame.width * 2, 0, screenWidth, screenHeight)
        
        // Pass down the scrollView so child knows the current view offset after swipe
        View1.parentScrollView = self.baseScrollView
        View2.parentScrollView = self.baseScrollView
        View3.parentScrollView = self.baseScrollView
        
        // Set size of ScrollView content size on parent view
        self.baseScrollView.contentSize = CGSizeMake(screenWidth * 3, self.view.frame.height)
        self.baseScrollView.contentOffset = CGPoint(x: screenWidth, y: 0)
        
        // Add the three VCs on top of the ScrollView
        self.baseScrollView.addSubview(View1.view)
        self.baseScrollView.addSubview(View2.view)
        self.baseScrollView.addSubview(View3.view)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
