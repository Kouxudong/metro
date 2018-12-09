//
//  LandmarksTableViewCell.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/8.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class LandmarksTableViewCell: UITableViewCell {

    @IBOutlet weak var LandmardsImage: UIImageView!
    @IBOutlet weak var LandmarksLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
