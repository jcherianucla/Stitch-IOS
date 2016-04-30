//
//  GalleryCell.swift
//  Picasso
//
//  Created by Jahan Cherian on 4/30/16.
//  Copyright © 2016 Akhil Nadendla. All rights reserved.
//

import UIKit

class GalleryCell: UITableViewCell {

    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(date: String, image: UIImage)
    {
        self.galleryImage.image = image
        self.dateLabel!.text = date
    }

}
