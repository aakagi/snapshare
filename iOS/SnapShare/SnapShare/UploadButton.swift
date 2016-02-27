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


class UploadButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parentVC: UIViewController? {
        didSet {
            initWorkaround()
        }
    }
    let buttonHeight = CGFloat(50)
    
    var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    var uploadFileURLs = Array<NSURL?>()

    
    func initWorkaround() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.frame = CGRectMake(0, screenHeight - self.buttonHeight, screenWidth, self.buttonHeight)
        self.backgroundColor = UIColor.blueColor()
        self.setTitle("Upload My Story", forState: UIControlState.Normal)
        self.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        let error = NSErrorPointer()
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(
                NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload"),
                withIntermediateDirectories: true,
                attributes: nil)
        } catch let error1 as NSError {
            error.memory = error1
            print("Creating 'upload' directory failed. Error: \(error)")
        }
        
        
    }
    
    
    
    func test() {
        print("test")
        
        // Creates alert controller
        let alertController = UIAlertController(
            title: "Available Actions",
            message: nil,
            preferredStyle: .ActionSheet)
        
        // Select this for uploading a new video
        let uploadNewVideo = UIAlertAction(
            title: "Upload A New Video",
            style: .Default) { (action) -> Void in
                 self.selectPictures()
        }
        alertController.addAction(uploadNewVideo)
        
        // Select this for updating an old video
        let updateOldVideo = UIAlertAction(
            title: "Upload Your Current Story",
            style: .Default) { (action) -> Void in
                 self.selectPictures()
        }
        alertController.addAction(updateOldVideo)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .Cancel) { (action) -> Void in }
        alertController.addAction(cancelAction)
        
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
        
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
        
        
        if let type: AnyObject = mediaType {
            if type is String {
                
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                    if let url = urlOfVideo {
                        print(url)
                        // Save to cloud
                        // Make API request to save video
                        
                    }
                }
                else if stringType == kUTTypeImage as String {
//                    let image = info[UIImagePickerControllerOriginalImage] as? UIImage
                    
                }
                
            }
        }
        
        parentVC!.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                self.collectionView.reloadData()
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
                    if let index = self.indexOfUploadRequest(self.uploadRequests, uploadRequest: uploadRequest) {
                        self.uploadRequests[index] = nil
                        self.uploadFileURLs[index] = uploadRequest.body
                        
                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
                        print(indexPath)
//                        self.collectionView.reloadItemsAtIndexPaths([indexPath])
                    }
                })
            }
            return nil
        }
    }
    
    func indexOfUploadRequest(array: Array<AWSS3TransferManagerUploadRequest?>, uploadRequest: AWSS3TransferManagerUploadRequest?) -> Int? {
        for (index, object) in array.enumerate() {
            if object == uploadRequest {
                return index
            }
        }
        return nil
    }
    
    
    

}
