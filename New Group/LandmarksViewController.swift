//
//  LandmarksViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/8.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class LandmarksViewController: UITableViewController {
    let workouts = PersistenceManager.sharedInstance.fetchWorkouts()
    let fetchLandmark = FetchLandmarksManager()
    var station : Station?
    var landmarks = [Landmark](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLandmark.delegate = self
        if let lon = station?.lon,let lat = station?.lat{
            fetchLandmark.fetchLandMarks(latitude: lat, longitude: lon)
        }
    }

    // MARK: - Table view data source

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
        
    /*   if let imgUrlString = landmark.imageUrl,
        let url = URL(string: imgUrlString) {
            cell.LandmarkImgLabel.load(url: url)
       }
       */
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

extension LandmarksViewController: FetchLandMarksDelegate{
    
    func landmarkFound(_ landmarks: [Landmark]) {
    
        print("landmark found")
        self.landmarks = landmarks
    }
    
    func landmarkNotFound(reason: FetchLandmarksManager.FailureReason) {
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
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
}

