//
//  FinishedMergingViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class FinishedMergingViewController: UIViewController {
    @IBOutlet weak var stitchedImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stitchedImage.image = outputImage
        saveImage(UIImageJPEGRepresentation(outputImage, 1.0)!)
        // Do any additional setup after loading the view.
    }
    func saveImage(data : NSData) {
        
        // Get file path poining to documents directory
        let filePath: String
        let stickerUsed: String
        let defaults = NSUserDefaults.standardUserDefaults()
        if let count : Int = defaults.integerForKey("StitchMasterCount") {
            print("current count")
            print(count)
            defaults.setInteger(count+1, forKey: "StitchMasterCount")
            stickerUsed = "/merged_image_\(count+1).jpg"
        }
        else {
            print("first storage so count is 1")
            defaults.setInteger(1, forKey: "StitchMasterCount")
            stickerUsed = "/merged_image_\(1).jpg"
        }
        filePath = self.getDocumentsDirectory().stringByAppendingPathComponent(stickerUsed)
        
        // We could try if there is file in this path (.fileExistsAtPath())
        // BUT we can also just call delete function, because it checks by itself
        do {
            try NSFileManager.defaultManager().removeItemAtPath(filePath)
        }
        catch _ {
            print("Did not accurately remove image")
        }
        
        
        // Write new image
        data.writeToFile(filePath, atomically: true)
        
        // Save your stuff to
        NSUserDefaults.standardUserDefaults().setObject(filePath, forKey: stickerUsed)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
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
