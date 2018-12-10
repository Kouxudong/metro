//
//  LandmarksDetailTableViewCell.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/9.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class LandmarksDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var LandmarkNameLabel: UILabel!
    
    @IBOutlet weak var LandmarkImageLabel: UIImageView!
    
    @IBOutlet weak var LandmarkRatingLabel: UILabel!
    
    @IBOutlet weak var LandmarkAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
