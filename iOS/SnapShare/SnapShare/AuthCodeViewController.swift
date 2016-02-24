//
//  AuthCodeViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/14/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit


class AuthCodeViewController: UIViewController {
    
    
    // TODOs
    // - Rebuild entire UI programatically (Maybe, this one isn't too bad)
    // - Make "Sending snap..." dynamic so it receives an API ping to update to "Snap sent!"
    // - Build a nice error pop-over
    // - Create a friendlier color pallette
    // - Change the background color
    // - Find better fonts
    

    // Set at UserSignInViewController prepareForSegue
    var actualCode: String?
    var snapname: String?
    
    var loggedInUser: User?
    
    // The input display labels
    @IBOutlet weak var codeInput1: UILabel!
    @IBOutlet weak var codeInput2: UILabel!
    @IBOutlet weak var codeInput3: UILabel!
    @IBOutlet weak var codeInput4: UILabel!
    
    // Throw the labels into an array
    var codeInputArray = [UILabel]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO - Get the actual access token and Id from UserSignInViewController
        
        print(self.actualCode!)
        print(self.snapname!)
        
    }
    
    // Triggered when a number is entered
    @IBAction func numberButtonPressed(sender: UIButton) {
        // Set the codeInputArray here because Swift is annoying and I can't do it at the top
        codeInputArray = [codeInput1,codeInput2,codeInput3,codeInput4]
        
        // Get the pressed digit
        let digit = sender.currentTitle!
        // Set the label text to the number
        codeInputArray[currentIndex].text = digit
        // Prepare for the next number
        currentIndex += 1
        
        // Trigger when the last number is entered
        if currentIndex == 4 {
            // Convert array of entered numbers to a single string
            var codeAttempt = ""
            for i in codeInputArray {
                codeAttempt += i.text!
            }
            // Validate code with authCode
            submitAuthCode(codeAttempt)
            currentIndex = 0
        }
    }
    
    // TODO - Move this to User model, again was too lazy to do it properly with closures and shit
    func submitAuthCode(submittedCode: String) {
        
        User.login(self.snapname!, submittedCode: submittedCode, result: {(resultUser, err) in
            if err != nil {
                self.presentError("Please try again.", message: err!)
            }
            else {
                
                self.loggedInUser = resultUser!
                
                // TODO - Set NSUserDefaults to store session
//                 let userSessionKey = self.loggedInUser.sessionKey
                // NSUserDefaults.standardUserDefaults().setObject(, forKey: "storedUser")
                
                self.performSegueWithIdentifier("SegueToMain", sender: self)
            }
        })
        
    }
    
    func presentError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: {() in self.resetInputFields()})
    }
    
    func resetInputFields() {
        if self.currentIndex == 0 {
            for i in self.codeInputArray {
                i.text = "-"
            }
        }
    }
    
    // Called for deleting a number
    @IBAction func deleteNumber() {
        if currentIndex > 0 {
            currentIndex -= 1
            codeInputArray[currentIndex].text = "-"
        }
    }
    
}
