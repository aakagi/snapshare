//
//  VideoTableTableViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/12/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit
import AVFoundation

class VideoTableViewController: UITableViewController {

    
    var videos = [[NSURL]]()
    
    // Mark: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let request = VideoRequest(count: 10ish)
        //request.fetchStuff { closure function
        //dispatch_async(dispatch_get_main_queue()) {} async load the videos
        //}
        
        videos.insert([NSURL(string: "http://www.akagi.co/video/snapstory1.m4v")!,NSURL(string: "http://www.akagi.co/video/snapstory2.m4v")!,NSURL(string: "http://www.akagi.co/video/snapstory1.m4v")!,NSURL(string: "http://www.akagi.co/video/snapstory2.m4v")!], atIndex: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return videos.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos[section].count
    }

    private struct StoryBoard {
        static let CellReuseIdentifier = "Video"
    }
    
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    var tempBtn: UIButton?
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier, forIndexPath: indexPath) as! EachVideoTableViewCell
        
        let thisVideo = videos[indexPath.section][indexPath.row]
        
        cell.video = thisVideo
        
//        playerItem = AVPlayerItem(URL: thisVideo)
//        player = AVPlayer(playerItem: playerItem!)
//        
//        let playerLayer = AVPlayerLayer(player: player!)
//        playerLayer.frame = CGRectMake(0,50,self.view.frame.size.width,200)
//        self.view.layer.addSublayer(playerLayer)
//        
//        tempBtn?.frame = CGRectMake(10,10,50,50)
//        tempBtn?.setTitle("ayeee", forState: UIControlState.Normal)
//        
//        
//        
//        player!.play()
        


        return cell
    }
    
    

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
