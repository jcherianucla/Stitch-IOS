//
//  PickImageViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class PickImageViewController: UIViewController {

    @IBOutlet var ConfirmCancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfirmCancelButton.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CameraPressed(sender: AnyObject) {
        
    }
    @IBAction func UrlPressed(sender: AnyObject) {
        
    }
    @IBAction func ConfirmCancelPressed(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }

}
