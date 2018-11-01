//
//  postCell.swift
//  instaClone
//
//  Created by Kyle Mamiit (New) on 10/31/18.
//  Copyright © 2018 Kyle Mamiit. All rights reserved.
//

import UIKit


class postCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
