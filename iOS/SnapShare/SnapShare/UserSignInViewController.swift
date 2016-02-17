//
//  UserSignInViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/14/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController, UITextFieldDelegate {
    
    // TODOs
    // - Rebuild entire UI programatically
    // - Programatically show who you will be receiving a snap from
    // - Figure out how to programatically send snaps?
    // - Generate auth codes and get them to me via email
    // - Actually pass the auth code along to the AuthCodeViewController :(
    // - Create a friendlier color pallette
    // - Change the background color
    // - Find better fonts
    
    @IBOutlet weak var userNameInputField: UITextField!
    
    
    // Mark: On Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoardReadyOnLoad()
        
    }
    func keyBoardReadyOnLoad() {
        userNameInputField.returnKeyType = UIReturnKeyType.Send
        userNameInputField.delegate = self
        self.userNameInputField.becomeFirstResponder()
    }
    
    
    // Mark: Submit Username
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if userNameInputField.text != nil {
            
            sendSnap(userNameInputField.text)
            return true
        }
        else {
            
            // TODO: Handle error
            
            print("error")
            
            return false
        }
    }

    func sendSnap(snapname: String?) {
        // Validate snapname
        if usernameValid(snapname) == true {
            
            // Get HttpHelper class
            let httpHelper = HttpHelper()
            // Create POST request to /user/login
            let httpRequest = httpHelper.buildJsonRequest("user/login", method: "POST")
            // With body {snapname: snapname} JSON
            let jsonBody = "{\"snapname\":\"\(snapname!)\"}"
            // Attach JSON
            httpRequest.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
            
            // TODO - All of this http stuff should be dealt with in User.swift
            
            // Send request
            var resDataString: String?
            let task = NSURLSession.sharedSession().dataTaskWithRequest(httpRequest) {(data, res, err) in
                if err == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        // Data successfully received
                        
                        // Convert result data to string
                        resDataString = String(data: data!, encoding: NSUTF8StringEncoding)!
                        // Make that into a dictionary
                        let resDictionary = httpHelper.convertStringToDictionary(resDataString!)
                        // Get the parts of the dictionary and assign them to variables
                        let loggingInUserId = "\(resDictionary!["_id"])"
                        let accessToken = "\(resDictionary!["accessToken"])"
                        
                        // TODO - Pass these two variables to AuthCodeViewController
                        
                        print("\(loggingInUserId) \(accessToken)")
                        
                        self.segueToVCInMainStoryboard("CodeVC")
                    }
                }
                else {
                    print("error!")
                }
            }
            task.resume()
            
        }
        else {
            
            // TODO - Deal with error
            
            print("Username not valid")
        }
    }
    
    func usernameValid(snapname: String?) -> Bool {
        
        // TODO - Needs more validation
        
        if snapname?.characters.count >= 3 {
            return true
        }
        else {
            return false
        }
    }
    
    func segueToVCInMainStoryboard(chosenVC: String) {
        // Manual Storyboard Segue
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcObj: UIViewController = Storyboard.instantiateViewControllerWithIdentifier(chosenVC)
        self.presentViewController(vcObj, animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        let destVC = segue.destinationViewController as! AuthCodeViewController
//        destVC.accessToken = "2222"
        
    }

}
