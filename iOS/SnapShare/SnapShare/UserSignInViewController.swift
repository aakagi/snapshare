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
    // - Create a friendlier color pallette
    // - Change the background color
    // - Find better fonts
    
    @IBOutlet weak var snapnameInputField: UITextField!
    
    var generatedCode: String?
    var snapname: String?
    
    
    // Mark: On Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start with keyboard open
        keyBoardReadyOnLoad()
        
    }
    
    func keyBoardReadyOnLoad() {
        snapnameInputField.returnKeyType = UIReturnKeyType.Send
        snapnameInputField.delegate = self
        self.snapnameInputField.becomeFirstResponder()
    }
    
    
    // Mark: Submit Username
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if snapnameIsValid(snapnameInputField.text) == true {
            sendSnap(snapnameInputField.text!)
            return true
        }
        else {
            print("error")
            return false
        }
    }
    
    
    // TODO - Eventually move to User class, but that's too much for now
    func sendSnap(snapname: String) {
        
        // Create POST request to /user/login with body {snapname: snapname} JSON
        let jsonBody = "{\"snapname\":\"\(snapname)\"}"
        let httpRequest = HttpHelper.buildJsonRequest("/user/auth", method: "POST", jsonBody: jsonBody)

        
        HttpHelper.sendRequest(httpRequest) { (err, res) in
            if res != nil {
                
                dispatch_async(dispatch_get_main_queue()) {
                    // TODO - Delete accessCode
                    let accessCode = "\(res!["accessToken"]!)"
                    
                    let _id = "\(res!["_id"]!)"
                    self.snapname = "\(res!["snapname"]!)"
                    
                    print(accessCode)
                    print(_id)
                    print(self.snapname!)
                    
                    self.performSegueWithIdentifier("GoToCodeVC", sender: self)
                }
            }
            else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentError("Error", message: "Something went wrong. Make sure you're connected to the internet, otherwise, I have no clue.")
                }
            }
        }
        
    }

    
    func snapnameIsValid(snapname: String?) -> Bool {
        
        // TODO - Needs more validation
        
        if snapname?.characters.count >= 3 {
            return true
        }
        else {
            return false
        }
    }
    
    func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? AuthCodeViewController {
            destVC.snapname = sender?.snapname!
        }
    }

}
