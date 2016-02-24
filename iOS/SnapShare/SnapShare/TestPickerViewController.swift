//
//  TestPickerViewController.swift
//  SnapShare
//
//  Created by Alexander Akagi on 2/22/16.
//  Copyright © 2016 Alexander Akagi. All rights reserved.
//

import UIKit

class TestPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerRect = CGRectMake(0, 0, self.view.frame.width, 200)
        let picker = UIImagePickerController()
        picker.view.frame = pickerRect
//        picker.view.backgroundColor = UIColor.yellowColor()
        
        self.view.addSubview(picker.view)

        // Do any additional setup after loading the view.
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
