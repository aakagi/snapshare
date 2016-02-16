//
//  AuthCodeViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/14/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class AuthCodeViewController: UIViewController {

    @IBOutlet weak var codeInput1: UILabel!
    @IBOutlet weak var codeInput2: UILabel!
    @IBOutlet weak var codeInput3: UILabel!
    @IBOutlet weak var codeInput4: UILabel!
    
    var codeInputArray = [UILabel]()
    var currentIndex = 0
    
    @IBAction func numberButtonPressed(sender: UIButton) {
        codeInputArray = [codeInput1,codeInput2,codeInput3,codeInput4]
        
        let digit = sender.currentTitle!
        codeInputArray[currentIndex].text = digit
        currentIndex += 1
        
        if currentIndex == 4 {
            var code = ""
            for i in codeInputArray {
                code += i.text!
            }
            submitAuthCode(code)
            currentIndex = 0
        }
    }
    
    @IBAction func deleteNumber() {
        if currentIndex > 0 {
            currentIndex -= 1
            codeInputArray[currentIndex].text = "-"
        }
    }
    
    func submitAuthCode(authCode: String) {
        print("Verifying code: \(authCode) - todo")
        
        // Manual Storyboard Segue
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VideoTableVC: UIViewController = Storyboard.instantiateViewControllerWithIdentifier("VideoTableVC")
        self.presentViewController(VideoTableVC, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("token: \(User.accessToken)")

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
    
    
    //    @IBAction func tappedEnter() {
    //        opStack.append(displayValue)
    //        print("opStack: \(opStack)")
    //        userIsTyping = false
    //    }
    //
    //    @IBAction func backspace() {
    //        if(display.text!.characters.count == 1) {
    //            display.text = "0"
    //        }
    //        else {
    //            display.text = String(display.text!.characters.dropLast())
    //        }
    //    }
    //
    //    func performOperation(operation: (Double, Double) -> Double) {
    //        if opStack.count >= 2 {
    //            displayValue = operation(opStack.removeLast(), opStack.removeLast())
    //            tappedEnter()
    //        }
    //        
    //    }
    


}
