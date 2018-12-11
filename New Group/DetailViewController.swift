//
//  DetailViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/10.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let name : String = ""
   // let rating:
    let address: String = ""
    var landmark : Landmark?
    @IBOutlet weak var LandmarkNameLabel: UILabel!
    
    @IBOutlet weak var LandmarkRatingLabel: UILabel!
    
    @IBOutlet weak var LandmarkAddressLabel: UILabel!
    @IBOutlet weak var LandmarkImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LandmarkNameLabel.text = landmark?.name
       // LandmarkRatingLabel.text = landmark?.rating
        LandmarkAddressLabel.text = landmark?.address
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
