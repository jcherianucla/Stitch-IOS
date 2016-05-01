//
//  MergeImagesViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

var outputImage = UIImage()

class MergeImagesViewController: UIViewController {
    
    @IBOutlet var TopButton: UIButton!
    @IBOutlet var BottomButton: UIButton!
    @IBOutlet var MergeButton: UIButton!
    
    @IBOutlet var BottomImage: UIImageView!
    @IBOutlet var TopImage: UIImageView!
    var topImageActive: Bool = false
    var bottomImageActive: Bool = false
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
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
        if let selectedImage = retrieveSavedImage(true)
        {
            if retrieveSavedImage(false) != nil
            {
                postImage(1, imageStyle: 1, image: selectedImage)
            }
        }

            //  performSegueWithIdentifier("showMergedImage", sender: self)
    }
    
    func postImage(UID: Int, imageStyle: Int, image:UIImage)
    {
        let parameters = [
            "id": "\(UID)",
            "type" : "\(imageStyle)"
        ]
        
        let URL = "http://54.89.149.163/upload"
        
        Alamofire.upload(.POST, URL, multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.5)
            {
                multipartFormData.appendBodyPart(data: imageData, name: "upload", fileName: "file.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                    
                case .Success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) in
                        if(response.response?.statusCode == 200)
                        {
                            self.postSecondImage(1, imageStyle: 2, image: self.retrieveSavedImage(false)!)
                        }
                        debugPrint(response)
                    })
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    func postSecondImage(UID: Int, imageStyle: Int, image:UIImage)
    {
        let parameters = [
            "id": "\(UID)",
            "type" : "\(imageStyle)"
        ]
        
        let URL = "http://54.89.149.163/upload"
        
        Alamofire.upload(.POST, URL, multipartFormData: {
            multipartFormData in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.5)
            {
                multipartFormData.appendBodyPart(data: imageData, name: "upload", fileName: "file.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                    
                case .Success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) in
                        if(response.response?.statusCode == 200)
                        {
                            self.activityView.center = self.view.center
                            self.activityView.startAnimating()
                            self.view.addSubview(self.activityView)
                            self.getImage()
                        }
                        debugPrint(response)
                    })
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    }

    func getImage()
    {
        Alamofire.request(.GET, "http://54.89.149.163/out.png").responseImage { (response) in
            if(response.response?.statusCode == 200)
            {
                self.activityView.stopAnimating()
                if let image = response.result.value
                {
                    print("image downloaded: \(image)")
                    outputImage = image
                    self.performSegueWithIdentifier("showMergedImage", sender: self)
                    
                }
            } else {
                self.getImage()
                print("still getting image")
            }
        }
    }
    
}
