//
//  NavScrollBar.swift
//  Major Key
//
//  Created by Alexander Akagi on 2/24/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class NavScrollBar: UINavigationBar, UINavigationBarDelegate {
    
    let navHeight = CGFloat(54)

    var leftButtonString: String?
    var rightButtonString: String?

    var parentVC: ScrollViewChildVC? {
        didSet {
            initWorkaround()
        }
    }
        
    func initWorkaround() {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        self.frame = CGRectMake(0, 0, screenWidth, navHeight)
        self.backgroundColor = UIColor.whiteColor()
        self.delegate = self;
        
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
        self.items = [navigationItem]

    }
    
    func navButtonClicked(sender: UIBarButtonItem) {
        // Goes right by default
        let currentX = self.parentVC!.parentScrollView!.contentOffset.x
        var screenDelta = self.parentVC!.parentScrollView!.frame.width
        
        if sender.tag == 0 {
            screenDelta *= -1
        }
        
        UIView.animateWithDuration(0.3, animations: {() in
            self.parentVC!.parentScrollView!.contentOffset = CGPoint(x: currentX + screenDelta, y: 0)
        })
    }
}
