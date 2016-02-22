//
//  ScrollViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/19/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    
    var testScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Create UIScrollView
        let scrollViewRect = CGRectMake(0, 0, screenWidth, screenHeight)
        self.testScrollView = UIScrollView(frame: scrollViewRect)
        self.testScrollView.delegate = self
        self.testScrollView.backgroundColor = UIColor.blackColor()
        self.testScrollView.pagingEnabled = true
        
        self.view.addSubview(testScrollView)
        
        // Initialize the three VCs
        let Test1: ScrollViewChildVC = ScrollViewChildVC()
        let Test2: ScrollViewChildVC = ScrollViewChildVC()
        let Test3: ScrollViewChildVC = ScrollViewChildVC()
        self.addChildViewController(Test1)
        self.addChildViewController(Test2)
        self.addChildViewController(Test3)
        Test1.didMoveToParentViewController(self)
        Test2.didMoveToParentViewController(self)
        Test3.didMoveToParentViewController(self)

        // Nav bar items
        Test1.rightButtonString = "Videos"
        Test2.leftButtonString = "Settings"
        Test2.rightButtonString = "User"
        Test3.leftButtonString = "Videos"
        
        Test2.fetchVideosParam = "Something1"
        Test3.fetchVideosParam = "Something2"
        
        // Set frames for the three VCs
        Test1.view.frame = CGRectMake(self.view.frame.width * 0, 0, screenWidth, screenHeight)
        Test2.view.frame = CGRectMake(self.view.frame.width * 1, 0, screenWidth, screenHeight)
        Test3.view.frame = CGRectMake(self.view.frame.width * 2, 0, screenWidth, screenHeight)
        
        // Pass down the scrollView so child knows the current view offset after swipe
        Test1.parentScrollView = self.testScrollView
        Test2.parentScrollView = self.testScrollView
        Test3.parentScrollView = self.testScrollView

        // Set size of ScrollView content size on parent view
        self.testScrollView.contentSize = CGSizeMake(screenWidth * 3, self.view.frame.height)
        self.testScrollView.contentOffset = CGPoint(x: screenWidth, y: 0)
        
        // Add the three VCs on top of the ScrollView
        self.testScrollView.addSubview(Test1.view)
        self.testScrollView.addSubview(Test2.view)
        self.testScrollView.addSubview(Test3.view)

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
