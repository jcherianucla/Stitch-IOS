//
//  GalleryTableViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

var SelectedStitch = UIImage()

class GalleryTableViewController: UITableViewController {
    
    //DEMO VARIABLES - Specified names are loaded
    var gallery = [UIImage]()
    var imageNames:[String] = ["deep_omar","deep_ali", "deep_jahan", "deep_emilia", "deep_mylo", "deep_venice", "deep_beard", "deep_bear", "deep_amanda", "deep_jahan"]
    var generatedCount: Int = 0

    var stitchToSend = UIImage()
    var masterCount: Int = 0
    //DEMO CODE - Loads images statically from the Assets folder
    func loadImages()
    {
        for imageString in self.imageNames
        {
            let image:UIImage = UIImage(named: imageString)!
            gallery.append(image)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadImages()
        backButton.tintColor = UIColor.whiteColor()
        if let count : Int = NSUserDefaults.standardUserDefaults().integerForKey("StitchMasterCount") {
            masterCount = count
            for i in 1...4
            {
                gallery.append(retrieveSavedImage(i)!)
            }
            print(gallery.count)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBOutlet weak var backButton: UIBarButtonItem!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gallery.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.bounds.height / 5)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.row <= masterCount{
//            self.stitchToSend = retrieveSavedImage(indexPath.row+1)!
//        }
//        else {
//            self.stitchToSend =  UIImage(named: imageNames[indexPath.row-(masterCount+1)])!
//        }
        self.stitchToSend = gallery[indexPath.row]
        performSegueWithIdentifier("showCurrentStitch", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCurrentStitch" {
            //let stitchViewController: StitchViewController = segue.destinationViewController as! StitchViewController
            SelectedStitch = stitchToSend
        }

    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! GalleryCell

        // Configure the cell...
//        print(masterCount)
//        if masterCount > 0 && indexPath.row <= masterCount{
//            if let storedImage = retrieveSavedImage(indexPath.row+1) {
//                cell.loadData("04/30/2016", image: storedImage)
//            }
//        }
//        else {
//            cell.loadData("04/30/2016", image: gallery[generatedCount])
//            generatedCount += 1
//        }
        cell.loadData("04/30/2016", image: gallery[indexPath.row])
        return cell
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    func retrieveSavedImage(count: Int) -> UIImage? {
        // Get file path poining to documents directory
        let filePath: String
        filePath = self.getDocumentsDirectory().stringByAppendingPathComponent("/merged_image_\(count).jpg")
        // Get image from file on given local url
        return UIImage(contentsOfFile: filePath)
    }
    
    @IBAction func ExitGalleryPresed(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }
}
