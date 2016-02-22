//
//  VideoTableTableViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController, UINavigationBarDelegate {
    var videos = [[Video]]()
    
    // Mark: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Video.getTopVideos(3, result: { (videoArray, error) in
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

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
