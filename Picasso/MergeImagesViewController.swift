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
    var topImageActive: Bool = false
    var bottomImageActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToMergeImagesView(unwindSegue: UIStoryboardSegue) {
        topImageActive = false
        bottomImageActive = false
        if let pickImageViewController = unwindSegue.sourceViewController as? PickImageViewController {
            print("Coming from Pick Image Screen")
            print("Is bottom image active?"); print(pickImageViewController.bottomImageActive)
            print("Is top image active?"); print(pickImageViewController.topImageActive)
            print("Is url image active?"); print(pickImageViewController.urlImageActive)
            if(pickImageViewController.topImageActive){
                if pickImageViewController.urlImageActive {
                    TopImage.image = retrieveURLSavedImage(true)
                } else {
                    
                }
            }
            else if (pickImageViewController.bottomImageActive){
                if pickImageViewController.urlImageActive {
                    BottomImage.image = retrieveURLSavedImage(false)
                } else {
                    
                }
            }
        }
    }
    func retrieveURLSavedImage(top: Bool) -> UIImage{
        var documentsDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,  true)
        if paths.count > 0 {
            documentsDirectory = paths[0] as? String
            if top {
                let savePath = documentsDirectory! + "/top_downloaded_image.jpg"
                return UIImage(named: savePath)!
            }
            else {
                let savePath = documentsDirectory! + "/bottom_downloaded_image.jpg"
                print(savePath)
                return UIImage(named: savePath)!
            }
        }
        return UIImage()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImagePicker" {
            let pickImageViewController: PickImageViewController = segue.destinationViewController as! PickImageViewController
            pickImageViewController.setBottomAndTop(bottomImageActive, top: topImageActive)
        }
    }
    
    @IBAction func TopPressed(sender: AnyObject) {
        topImageActive = true
        performSegueWithIdentifier("showImagePicker", sender: self)
    }
    @IBAction func BottomPressed(sender: AnyObject) {
        bottomImageActive = true
        performSegueWithIdentifier("showImagePicker", sender: self)
    }
    @IBAction func MergePressed(sender: AnyObject) {
        performSegueWithIdentifier("showMergedImage", sender: self)
    }
    
}
