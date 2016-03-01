//
//  TestButton.swift
//  Major Key
//
//  Created by Alexander Akagi on 2/24/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

import MobileCoreServices
import AssetsLibrary


class UploadButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    var parentVC: UIViewController? {
        didSet {
            initWorkaround()
        }
    }
    let buttonHeight = CGFloat(50)
    var currentUser: User?
    
    func initWorkaround() {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.frame = CGRectMake(0, screenHeight - self.buttonHeight, screenWidth, self.buttonHeight)
        self.backgroundColor = UIColor.blueColor()
        self.setTitle("Upload My Story", forState: UIControlState.Normal)
        self.addTarget(self, action: "selectPictures", forControlEvents: UIControlEvents.TouchUpInside)
        
    }


    func selectPictures() {
        
        let videoPicker = UIImagePickerController()
        
        videoPicker.delegate = self
        videoPicker.sourceType = .SavedPhotosAlbum
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.videoMaximumDuration = 5.0

        parentVC!.presentViewController(videoPicker, animated: true, completion: nil)

    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        parentVC!.dismissViewControllerAnimated(true, completion: nil)
        
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
        if let type: AnyObject = mediaType {
            if type is String {
                
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    
                    if let videoUrl = info[UIImagePickerControllerMediaURL] as? NSURL {

                        let uploadRequest = AWSS3TransferManagerUploadRequest()
                        
                        uploadRequest.body = videoUrl
                        uploadRequest.key = "testVideo1.m4v"
                        uploadRequest.bucket = ApiKeys.S3BucketName
  
                        Video.uploadVideo(currentUser!, uploadRequest: uploadRequest, result: { () in })
                        
                    }
                }
            }
        }
        
    }
    
}



/*

// TODO - Add this once updating videos is an option

func openActionSheet() {

// Creates alert controller
let alertController = UIAlertController(
title: "Upload Your Snap Story",
message: nil,
preferredStyle: .ActionSheet)

// Select this for uploading a new video
let uploadNewVideo = UIAlertAction(
title: "Add A New Story",
style: .Default) { (action) -> Void in
self.selectPictures()
}
alertController.addAction(uploadNewVideo)

// Select this for updating an old video
let updateOldVideo = UIAlertAction(
title: "Update Current Story",
style: .Default) { (action) -> Void in
self.selectPictures()
}
alertController.addAction(updateOldVideo)

// Cancel
let cancelAction = UIAlertAction(
title: "Cancel",
style: .Cancel) { (action) -> Void in }
alertController.addAction(cancelAction)

// Present the selection buttons
parentVC!.presentViewController(
alertController,
animated: true) { () -> Void in }

}
*/
