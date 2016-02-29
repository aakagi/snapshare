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
    
    func initWorkaround() {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.frame = CGRectMake(0, screenHeight - self.buttonHeight, screenWidth, self.buttonHeight)
        self.backgroundColor = UIColor.blueColor()
        self.setTitle("Upload My Story", forState: UIControlState.Normal)
        self.addTarget(self, action: "openActionSheet", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
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
    
    
    func selectPictures() {
        
        let videoPicker = UIImagePickerController()
        
        videoPicker.delegate = self

        videoPicker.sourceType = .SavedPhotosAlbum
        videoPicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]

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
                        uploadRequest.key = "testVideo.m4v"
                        uploadRequest.bucket = ApiKeys.S3BucketName
  
                        self.upload(uploadRequest)
                        
                    }
                    
                }
            }
        }

    }
    
    
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        print("upload started")
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in

                            })
                            break;
                            
                        default:
                            print("upload() failed: [\(error)]")
                            break;
                        }
                    } else {
                        print("upload() failed: [\(error)]")
                    }
                } else {
                    print("upload() failed: [\(error)]")
                }
            }
            
            if let exception = task.exception {
                print("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print(uploadRequest.key)
                    
                    // Create new video in DB
                    // Confirm video upload
                    
                    
                    
                })
            }
            return nil
        }
    }
    

}
