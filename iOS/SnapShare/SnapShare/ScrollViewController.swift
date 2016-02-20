//
//  ScrollViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/19/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the three VCs
        let Test1: ChildViewControllerOfScrollView = ChildViewControllerOfScrollView()
        let Test2: ChildViewControllerOfScrollView = ChildViewControllerOfScrollView()
        let Test3: ChildViewControllerOfScrollView = ChildViewControllerOfScrollView()
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
        
        // Set frames for the three VCs
        let screenWidth = self.scrollViewOutlet.frame.width
        let screenHeight = self.scrollViewOutlet.frame.height
        Test1.view.frame = CGRectMake(self.view.frame.width * 0, 0, screenWidth, screenHeight)
        Test2.view.frame = CGRectMake(self.view.frame.width * 1, 0, screenWidth, screenHeight)
        Test3.view.frame = CGRectMake(self.view.frame.width * 2, 0, screenWidth, screenHeight)
        
        Test1.parentScrollView = self.scrollViewOutlet
        Test2.parentScrollView = self.scrollViewOutlet
        Test3.parentScrollView = self.scrollViewOutlet

        // Set size of ScrollView content size on parent view
        self.scrollViewOutlet.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        self.scrollViewOutlet.contentOffset = CGPoint(x: self.view.frame.width, y: 0)
        
        // Add the three VCs on top of the ScrollView
        self.scrollViewOutlet.addSubview(Test1.view)
        self.scrollViewOutlet.addSubview(Test2.view)
        self.scrollViewOutlet.addSubview(Test3.view)
        
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
