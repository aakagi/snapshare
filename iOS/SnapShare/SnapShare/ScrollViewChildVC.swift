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
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the navigation bar - Note: time, battery life, etc has a height of 20
        let navHeight = CGFloat(54)
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, navHeight))
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Title"
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: leftButtonString, style: UIBarButtonItemStyle.Plain, target: self, action: "navButtonClicked:")
        let rightButton = UIBarButtonItem(title: rightButtonString, style: UIBarButtonItemStyle.Plain, target: self, action: "navButtonClicked:")
        // These tags are not a good solution because they aren't optionals!
        leftButton.tag = 0
        rightButton.tag = 1 // this isn't necessary, but I don't want my shit to crash...
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        

        
        let Test1: VideoTableViewController = VideoTableViewController()
        self.addChildViewController(Test1)
        Test1.didMoveToParentViewController(self)
        Test1.parentScrollUIVC = self
        Test1.view.frame = CGRectMake(0, navHeight, screenWidth, screenHeight)
        
        
        
        self.view.addSubview(Test1.view)
        
        
        
        if childViewController != nil {
//            childViewController
        }
        
//        childViewController = UIViewController()
//        childViewController!.view.frame = CGRectMake(0, 54, self.view.frame.width, self.view.frame.height - 54)
//        childViewController!.view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(Test1.view)
        

    }
    
    func navButtonClicked(sender: UIBarButtonItem) {
        // Goes right by default
        let currentX = self.parentScrollView!.contentOffset.x
        var screenDelta = self.parentScrollView!.frame.width
        
        
        if sender.tag == 0 {
            screenDelta *= -1
        }
        
        UIView.animateWithDuration(0.5, animations: {() in
            self.parentScrollView!.contentOffset = CGPoint(x: currentX + screenDelta, y: 0)
        })
    }

}
