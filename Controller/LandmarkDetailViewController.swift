//
//  LandmarkDetailViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/9.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UITableViewController {
    let fetchLandmarkDetail = FetchLandmarksDetailManager()
    var landmark : Landmark?
    var landmarksDetail = [LandmarkDetail](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        fetchLandmarkDetail.delegate = self as? FetchLandMarksDetailDelegate
        if let lat = landmark?.lat, let lon = landmark?.lon{
            fetchLandmarkDetail.fetchLandMarksDetail(latitude: lat, longitude: lon)
        }
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarksDetail.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkDetailNameCell", for: indexPath) as! LandmarksDetailTableViewCell
        
        let landmarkDetail = landmarksDetail[indexPath.row]
        
        cell.LandmarkNameLabel.text = landmarkDetail.name
        cell.LandmarkRatingLabel.text = String(landmarkDetail.rating)
        cell.LandmarkAddressLabel.text = landmarkDetail.address
        
        /*   if let imgUrlString = landmark.imageUrl,
         let url = URL(string: imgUrlString) {
         cell.LandmarkImgLabel.load(url: url)
         }
         */
        return cell
    }

    

}
extension LandmarkDetailViewController: FetchLandMarksDetailDelegate{
    func landmarkDetailFound(_ landmarksdetail: [LandmarkDetail]){
            print("detail found")
            self.landmarksDetail = landmarksdetail
    }
    
    func landmarkDetailNotFound(reason: FetchLandmarksDetailManager.FailureReason) {
        DispatchQueue.main.async {
            //MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching landmarks", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    // self.fetchLandmarks
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
           // self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
}
    
    
  
    

