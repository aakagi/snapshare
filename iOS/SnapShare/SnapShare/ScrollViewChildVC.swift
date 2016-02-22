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
    
    var fetchVideosParam: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TODO - Make the nav bar more abstract
        
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
        
        let uploadButtonHeight = CGFloat(50)
        
        let uploadButtonRect = CGRectMake(0, screenHeight - uploadButtonHeight, screenWidth, uploadButtonHeight)
        
        let uploadButton = UIButton(frame: uploadButtonRect)
        uploadButton.backgroundColor = UIColor.blueColor()
        uploadButton.setTitle("Upload My Story", forState: UIControlState.Normal)
        uploadButton.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
        
        let childViewRect = CGRectMake(0, navHeight, screenWidth, screenHeight - uploadButtonHeight)
        
        if self.fetchVideosParam != nil {
            let childVideoVC = VideoTableViewController()
            self.addChildViewController(childVideoVC)
            childVideoVC.didMoveToParentViewController(self)
            childVideoVC.view.frame = childViewRect
            self.view.addSubview(childVideoVC.view)
            self.view.addSubview(uploadButton)
        }
        else {
            // TODO - Settings Page
            let settingsVC = UIViewController()
            settingsVC.view.frame = childViewRect
            self.view.addSubview(settingsVC.view)
        }
        

    }
    
    func test() {
        print("here")
        
        downloadImage("profile.jpg")
        
    }
    
    
    func downloadImage(key: String){
        
        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        
        //downloading image
        
        
        let S3BucketName: String = "your_s3_bucketName"
        let S3DownloadKeyName: String = key
        
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.downloadProgress = {(task: AWSS3TransferUtilityTask, bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
            dispatch_async(dispatch_get_main_queue(), {
                let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
                //self.progressView.progress = progress
                //   self.statusLabel.text = "Downloading..."
                NSLog("Progress is: %f",progress)
            })
        }
        
        
        
        completionHandler = { (task, location, data, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if ((error) != nil){
                    NSLog("Failed with error")
                    NSLog("Error: %@",error!);
                    //   self.statusLabel.text = "Failed"
                }
                    /*
                    else if(self.progressView.progress != 1.0) {
                    //    self.statusLabel.text = "Failed"
                    NSLog("Error: Failed - Likely due to invalid region / filename")
                    }   */
                else{
                    //    self.statusLabel.text = "Success"
//                    self.collectionImages[S3DownloadKeyName] = UIImage(data: data!)
                    //reload the collectionView data to include new picture
//                    self.colView.reloadData()
                    print("Success! - In completionHandler")
                }
            })
        }
        
        let transferUtility = AWSS3TransferUtility.defaultS3TransferUtility()
        
        transferUtility.downloadToURL(nil, bucket: S3BucketName, key: S3DownloadKeyName, expression: expression, completionHander: completionHandler).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                NSLog("Error: %@",error.localizedDescription);
                //  self.statusLabel.text = "Failed"
            }
            if let exception = task.exception {
                NSLog("Exception: %@",exception.description);
                //  self.statusLabel.text = "Failed"
            }
            if let _ = task.result {
                //    self.statusLabel.text = "Starting Download"
                //NSLog("Download Starting!")
                // Do something with uploadTask.
                /*
                dispatch_async(dispatch_get_main_queue(), {
                self.colView.reloadData()
                })
                */
                
                print(task.result)
                
            }
            return nil;
        }
        
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
