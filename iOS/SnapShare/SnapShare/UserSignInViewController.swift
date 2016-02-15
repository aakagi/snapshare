//
//  UserSignInViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/14/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userNameInputField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameInputField.returnKeyType = UIReturnKeyType.Send
        
        userNameInputField.delegate = self
        
        self.userNameInputField.becomeFirstResponder()
        
//        self.userNameInputField.
//        print(self.userNameInputField)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // TODO
        if userNameInputField.text != nil {
            sendSnap(userNameInputField.text!)
            
            // Manual Storyboard Segue
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let CodeVC: UIViewController = Storyboard.instantiateViewControllerWithIdentifier("CodeVC")
            self.presentViewController(CodeVC, animated: true, completion: nil)
        }
        else {
            //send error
        }
        
        return true
    }
    
    // TODO - should also be called from different class
    func sendSnap(snapname: String) {
        print("Sending snap of auth code to \(snapname) - todo")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
