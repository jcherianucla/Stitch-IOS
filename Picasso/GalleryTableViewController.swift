//
//  GalleryTableViewController.swift
//  Picasso
//
//  Created by Akhil Nadendla on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class GalleryTableViewController: UITableViewController {
    
    //DEMO VARIABLES - Specified names are loaded
    var gallery = [UIImage]()
    var imageNames:[String] = ["deep_omar","deep_ali", "deep_jahan", "deep_emilia", "deep_mylo", "deep_venice", "deep_beard", "deep_bear", "deep_amanda", "deep_jahan"]
    
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! GalleryCell

        // Configure the cell...
        
        cell.loadData("04/30/2016", image: gallery[indexPath.row])

        return cell
    }
    @IBAction func ExitGalleryPresed(sender: AnyObject) {
        self.presentingViewController!.dismissViewControllerAnimated(false, completion: nil)
    }
}
