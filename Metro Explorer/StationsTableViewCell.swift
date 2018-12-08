//
//  StationsTableViewCell.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/6.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class StationsTableViewCell: UITableViewCell {

    @IBOutlet weak var StationLabel: UILabel!
    
    @IBOutlet weak var LonLabel: UILabel!
    
    
    @IBOutlet weak var LaiLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
