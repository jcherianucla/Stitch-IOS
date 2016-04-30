//
//  PickImageViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class PickImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var ConfirmCancelButton: UIButton!
    @IBOutlet var SelectedImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var textfield: UITextField? = nil
    var topImageActive: Bool = false
    var bottomImageActive: Bool = false
    var urlImageActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        ConfirmCancelButton.layer.cornerRadius = 15
        imagePicker.delegate = self
    }
    func setBottomAndTop(bottom: Bool, top: Bool){
        self.bottomImageActive = bottom
        self.topImageActive = top
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CameraPressed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.urlImageActive = false
            self.SelectedImage.image = image
            var documentsDirectory:String?
            var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,  true)
            if paths.count > 0 {
                documentsDirectory = paths[0] as? String
                var savePath: String = ""
                if self.topImageActive {
                    savePath = documentsDirectory! + "/top_downloaded_image.jpg"
                }
                else {
                    savePath = documentsDirectory! + "/bottom_downloaded_image.jpg"
                }
                NSFileManager.defaultManager().createFileAtPath(savePath, contents: UIImageJPEGRepresentation(image, 1.0), attributes: nil)
                //self.SelectedImage.image = UIImage(named: savePath)
                self.ConfirmCancelButton.setTitle("Confirm", forState: .Normal)
            }
        })
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
                var documentsDirectory:String?
                var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask,  true)
                if paths.count > 0 {
                    documentsDirectory = paths[0] as? String
                    var savePath: String = ""
                    if self.topImageActive {
                        savePath = documentsDirectory! + "/top_downloaded_image.jpg"
                    }
                    else {
                        savePath = documentsDirectory! + "/bottom_downloaded_image.jpg"
                    }
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    //self.SelectedImage.image = UIImage(named: savePath)
                    self.urlImageActive = true
                    self.ConfirmCancelButton.setTitle("Confirm", forState: .Normal)
                }
            }
            
        })
    }

}
