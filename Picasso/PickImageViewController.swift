//
//  PickImageViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit
import Photos

class PickImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var ConfirmCancelButton: UIButton!
    @IBOutlet var SelectedImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var textfield: UITextField? = nil
    var topImageActive: Bool = false
    var bottomImageActive: Bool = false
    var urlImageActive: Bool = false
    var allow:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfirmCancelButton.layer.cornerRadius = 15
        imagePicker.delegate = self
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .Authorized:
                self.allow = true
            case .Restricted:
                break;
            case .Denied:
                break;
            default:
                // place for .NotDetermined - in this callback status is already determined so should never get here
                break
            }
        }
    }
    func setBottomAndTop(bottom: Bool, top: Bool){
        self.bottomImageActive = bottom
        self.topImageActive = top
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isSourceTypeAvailable(sourceType: UIImagePickerControllerSourceType) -> Bool
    {
        return true
    }
    
    @IBAction func CameraPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        if(self.allow)
        {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.urlImageActive = false
                self.SelectedImage.image = image
                self.saveOverrideImage(UIImageJPEGRepresentation(image, 1.0)!)
                self.urlImageActive = true
                self.ConfirmCancelButton.setTitle("Confirm", forState: .Normal)
            })
        }
    }
    @IBAction func UrlPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Web Image", message: "Provide URL to choose an image on the web.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.text = "http://"
            self.textfield = textField
        }
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if self.textfield != nil {
                print(self.textfield!.text)
                self.downloadImage(self.textfield!.text!)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBAction func ConfirmCancelPressed(sender: AnyObject) {
    }
    @IBAction func unwindToMergeImagesView(segue: UIStoryboardSegue) {
        
    }
    func downloadImage (providedURL: String) {
        
        let url = NSURL(string: providedURL)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        //aysynch grap of the image
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            
            if error != nil {
                print("there was an error")
            }
            else {
                let image = UIImage(data: data!)
                //to set image directly
                self.SelectedImage.image = image
                
                //lets save the image instead and after the first time you wont need to download it anymore
                self.saveOverrideImage(data!)
                self.urlImageActive = true
                self.ConfirmCancelButton.setTitle("Confirm", forState: .Normal)
            }
            
        })
    }
    func saveOverrideImage(data : NSData) {
        
        // Get file path poining to documents directory
        let filePath: String
        let stickerUsed: String
        if self.topImageActive {
            filePath = self.getDocumentsDirectory().stringByAppendingPathComponent("/top_downloaded_image.jpg")
            stickerUsed = "/top_downloaded_image.jpg"
        }
        else {
            filePath = self.getDocumentsDirectory().stringByAppendingPathComponent("/bottom_downloaded_image.jpg")
            stickerUsed = "/bottom_downloaded_image.jpg"
        }
        
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
    
}
