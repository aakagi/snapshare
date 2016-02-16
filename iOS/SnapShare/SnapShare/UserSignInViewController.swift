//
//  UserSignInViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/14/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController, UITextFieldDelegate {
    
    var accessToken: String?
    var loggingInUserId: String?
    
    @IBOutlet weak var userNameInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard settings
        userNameInputField.returnKeyType = UIReturnKeyType.Send
        userNameInputField.delegate = self
        self.userNameInputField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // TODO
        if userNameInputField.text != nil {
            sendSnap(userNameInputField.text!)
            segueToVCInMainStoryboard("CodeVC")

        }
        else {
            //send error
        }
        
        return true
    }
    
    // TODO - should also be called from different class
    func sendSnap(snapname: String) {
        if snapname.characters.count >= 3 {
            
            // Get HttpHelper class
            let httpHelper = HttpHelper()
            // Create POST request to /user/login with body {snapname: snapname} JSON
            let httpRequest = httpHelper.buildJsonRequest("user/login", method: "POST")
            let jsonBody = "{\"snapname\":\"\(snapname)\"}"
            httpRequest.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
            
            var resDataString: String?

            let task = NSURLSession.sharedSession().dataTaskWithRequest(httpRequest) {(data, res, err) in
                if err != nil {
                    print(err)
                }
                else if data != nil {
                    resDataString = String(data: data!, encoding: NSUTF8StringEncoding)!
                    let resDictionary = httpHelper.convertStringToDictionary(resDataString!)
                    self.loggingInUserId = "\(resDictionary!["_id"])"
                    self.accessToken = "\(resDictionary!["accessToken"])"
                }
            }
            task.resume()
            
        }
        else {
            print("Username not valid")
        }
    }
    
    // MARK: - Navigation
    
    func segueToVCInMainStoryboard(chosenVC: String) {
        // Manual Storyboard Segue
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcObj: UIViewController = Storyboard.instantiateViewControllerWithIdentifier(chosenVC)
        self.presentViewController(vcObj, animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        print("\(self.accessToken)")
        
//    }

}
