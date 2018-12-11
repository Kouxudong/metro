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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .action
            , target: self, action: #selector(tapButton))
        
       //navigationItem.rightBarButtonItem = addButton
        let addButton1 = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(tapButton1))
       
       
        navigationItem.rightBarButtonItems = [addButton,addButton1]
       
        do{
            let imgUrlString = landmark?.imageUrl
            if let url = URL(string: imgUrlString!) {
                // let data = try Data(contentsOf: url)
                LandmarkImage.load(url: url)
            }
            
        }
        LandmarkNameLabel.text = landmark?.name
        LandmarkRatingLabel.text = "Rating: \((landmark?.rating) )"
        LandmarkAddressLabel.text = landmark?.address
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButton(_ sender: Any){
        print("your tap")
        let shareText = "share to others"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
        
    }
    @IBAction func tapButton1(_ sender: Any){
        print("your tap1")
        let workout = Landmark(name:(landmark?.name)!,rating:(landmark?.rating)!, address:(landmark?.address)!,imageUrl:(landmark?.imageUrl)!)
        PersistenceManager.sharedInstance.saveWorkout(workout: workout)    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
