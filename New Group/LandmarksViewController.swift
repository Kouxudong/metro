//
//  LandmarksViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/8.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD
class LandmarksViewController: UITableViewController {
    let locationdetector = LocationDetector()
    var distances = [Double]()
    var metrostation = [Station]()
    

    
    
    let workouts = PersistenceManager.sharedInstance.fetchWorkouts()
    let fetchLandmark = FetchLandmarksManager()
    var fromFav: Bool = false
    var station : Station?
    var landmarks = [Landmark](){
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLandmark.delegate = self
        locationdetector.delegate = self as? LocationDetectorDelegate
        locationdetector.findLocation()
        MBProgressHUD.showAdded(to: self.view, animated:true)
        if fromFav == true {
            landmarks = PersistenceManager.sharedInstance.fetchWorkouts()
        }
        else {
            fetchLandmark.delegate = self
            if let lon = station?.lon,let lat = station?.lat{
                fetchLandmark.fetchLandMarks(latitude: lat, longitude: lon)
            }
        }
    }

    // MARK: - Table view data source
    
//show all the information on the screen
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkDetailCell", for: indexPath) as! LandmarksTableViewCell
        
        let landmark = landmarks[indexPath.row]
        
        cell.LandmarkLabel.text = landmark.name
        
        do{
            let imgUrlString = landmark.imageUrl
            if let url = URL(string: imgUrlString) {
                // let data = try Data(contentsOf: url)
                cell.LandmarkImgLabel.load(url: url)
            }
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you select: \(indexPath.row)")
        
        performSegue(withIdentifier: "LandmarkDetailSegue", sender: indexPath.row)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = sender as! Int
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.landmark = landmarks[row]
    }
}
// find the landmark
extension LandmarksViewController: FetchLandMarksDelegate{
    
    func landmarkFound(_ landmarks: [Landmark]) {
        DispatchQueue.main.async{
            print("landmark found")
            self.landmarks = landmarks
            MBProgressHUD.hide(for: self.view, animated: true)        }
       
    }
    
    func landmarkNotFound(reason: FetchLandmarksManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
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
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
}

