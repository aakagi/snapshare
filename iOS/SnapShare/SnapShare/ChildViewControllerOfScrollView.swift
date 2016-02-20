//
//  TestView2ViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/19/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class ChildViewControllerOfScrollView: UIViewController, UINavigationBarDelegate {

    var parentScrollView: UIScrollView?
    var leftButtonString: String?
    var rightButtonString: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO - Delete these and get actual parameters
//        leftButtonString = "Settings"
//        rightButtonString = "User"
        
        // Create the navigation bar - Note: time, battery life, etc has a height of 20
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 54))
        
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Title"
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: leftButtonString, style: UIBarButtonItemStyle.Plain, target: self, action: "leftButtonClicked:")
        let rightButton = UIBarButtonItem(title: rightButtonString, style: UIBarButtonItemStyle.Plain, target: self, action: "rightButtonClicked:")
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        
        


        // Do any additional setup after loading the view.
    }
    func leftButtonClicked(sender: UIBarButtonItem) {
        let screenWidth = self.parentScrollView!.frame.width
        let currentX = self.parentScrollView!.contentOffset.x
        UIView.animateWithDuration(0.5, animations: {() in
            self.parentScrollView!.contentOffset = CGPoint(x: currentX - screenWidth, y: 0)
        })
    }

    func rightButtonClicked(sender: UIBarButtonItem) {
        let screenWidth = self.parentScrollView!.frame.width
        let currentX = self.parentScrollView!.contentOffset.x
        UIView.animateWithDuration(0.5, animations: {() in
            self.parentScrollView!.contentOffset = CGPoint(x: currentX + screenWidth, y: 0)
        })
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
