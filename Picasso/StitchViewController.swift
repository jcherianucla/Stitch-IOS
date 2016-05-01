//
//  StitchViewController.swift
//  Picasso
//
//  Created by Jahan Cherian on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class StitchViewController: UIViewController {

    @IBOutlet weak var currentStitch: UIImageView!
    var imageName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStitch.image = SelectedStitch
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
