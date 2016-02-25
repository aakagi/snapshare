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
    
    func initWorkaround() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        self.frame = CGRectMake(0, screenHeight - self.buttonHeight, screenWidth, self.buttonHeight)
        self.backgroundColor = UIColor.blueColor()
        self.setTitle("Upload My Story", forState: UIControlState.Normal)
        self.addTarget(self, action: "test", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func test() {
        print("test")
        
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

}
