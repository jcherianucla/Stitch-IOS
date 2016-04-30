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
                TopImage.image = retrieveSavedImage(true)
            }
            else if (pickImageViewController.bottomImageActive){
                BottomImage.image = retrieveSavedImage(false)
            }
        }
    }
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func retrieveSavedImage(top : Bool) -> UIImage? {
        // Get file path poining to documents directory
        let filePath: String
        if top {
            filePath = self.getDocumentsDirectory().stringByAppendingPathComponent("/top_downloaded_image.jpg")
        }
        else {
            filePath = self.getDocumentsDirectory().stringByAppendingPathComponent("/bottom_downloaded_image.jpg")
        }
        // Get image from file on given local url
        return UIImage(contentsOfFile: filePath)
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
