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

//        var homeTableView: VideoTableViewController = VideoTableViewController()
        
        print("self.view.frame.width \(self.view.frame.width)")
        
        let Test1: TestView1ViewController = TestView1ViewController(nibName: "TestView1ViewController", bundle: nil)
        let Test2: TestView2ViewController = TestView2ViewController()
        let Test3: TestView3ViewController = TestView3ViewController()
        
        self.addChildViewController(Test1)
        self.scrollViewOutlet.addSubview(Test1.view)
        Test1.didMoveToParentViewController(self)
        
        self.addChildViewController(Test2)
        self.scrollViewOutlet.addSubview(Test2.view)
        Test2.didMoveToParentViewController(self)

        self.addChildViewController(Test3)
        self.scrollViewOutlet.addSubview(Test3.view)
        Test3.didMoveToParentViewController(self)
        
        Test2.view.frame.origin.x = self.view.frame.width
        
        Test3.view.backgroundColor = UIColor.blueColor()        
        Test3.view.frame = CGRectMake(self.view.frame.width * 2, 0, self.view.frame.width, self.view.frame.height)
        
        print("Test1.view.frame.width \(Test1.view.frame.width)")
        print("Test3.view.frame.width \(Test3.view.frame.width)")
        
        print("self.view.frame.width \(self.view.frame.width)")
        
        self.scrollViewOutlet.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        self.scrollViewOutlet.contentOffset = CGPoint(x: self.view.frame.width, y: self.view.frame.height)
        
        
        
        
        
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
