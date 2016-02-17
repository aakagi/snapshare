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
                i.text = "-"
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
                print(err!)
            }
            else {
                print(resultUser!)
                self.performSegueWithIdentifier("GoToMainVideoTableVC", sender: self)
            }
        })
    }
    
    // Called for deleting a number
    @IBAction func deleteNumber() {
        if currentIndex > 0 {
            currentIndex -= 1
            codeInputArray[currentIndex].text = "-"
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        let destVC = segue.destinationViewController as! VideoTableViewController
//        destVC.actualCode = sender?.generatedCode!
//        destVC.snapname = sender?.snapname
//    }
    

}
