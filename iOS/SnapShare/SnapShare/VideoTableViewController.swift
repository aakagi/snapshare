//
//  VideoTableTableViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController {
    var videos = [[Video]]()
    
    var navBar: NavScrollBar?
    
    // Mark: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Video.fetchVideosFor("t", result: { (videoArray, error) in
            self.videos.insert(videoArray, atIndex: 0)
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return videos.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos[section].count
    }
    
    private let firstIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = EachVideoTableViewCell()
        
        cell.videoObj = videos[indexPath.section][indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath == firstIndexPath {
            cell.cellExpanded = true
        }
        else {
            cell.cellExpanded = false
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //        if indexPath == firstIndexPath {
        return UIScreen.mainScreen().bounds.width
        //        }
        //        else {
        //            return self.view.frame.width * 1/3
        //        }
        
    }
    
    
    
    
    func downloadImage(key: String){
        
        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        
        let S3BucketName: String = ApiKeys.S3BucketName
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
                    //                    else if(self.progressView.progress != 1.0) {
                    //                    //    self.statusLabel.text = "Failed"
                    //                    NSLog("Error: Failed - Likely due to invalid region / filename")
                    //                    }
                else{
                    
                    //                    let dataAsImg = UIImage(data: data!)
                    
                    //                    self.tempImage.image = dataAsImg
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
                NSLog("Download Starting!")
            }
            return nil;
        }
        
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
