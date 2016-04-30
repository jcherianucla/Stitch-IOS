//
//  MergeImagesViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class MergeImagesViewController: UIViewController {
    
    @IBOutlet var TopButton: UIButton!
    @IBOutlet var BottomButton: UIButton!
    @IBOutlet var MergeButton: UIButton!
    
    @IBOutlet var BottomImage: UIImageView!
    @IBOutlet var TopImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TopPressed(sender: AnyObject) {
        performSegueWithIdentifier("showImagePicker", sender: self)
    }
    @IBAction func BottomPressed(sender: AnyObject) {
        performSegueWithIdentifier("showImagePicker", sender: self)
    }
    @IBAction func MergePressed(sender: AnyObject) {
        performSegueWithIdentifier("showMergedImage", sender: self)
    }
    
}
