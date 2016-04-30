//
//  FinishedMergingViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class FinishedMergingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAnotherPortraitePressed(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
}
