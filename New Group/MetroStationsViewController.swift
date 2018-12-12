//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/11/29.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

class MetroStationsViewController: UITableViewController{
    let wmataapimanager = WmataAPIManager()
    let locationDetector = LocationDetector()
    var userLongitude = 1.0
    var userLatitude = 1.0
    var stations = [Station](){
        didSet{
            tableView.reloadData()
        }
    }
   
    override func viewDidLoad(){
        super.viewDidLoad()
        wmataapimanager.delegate = self as FetchStationsDelegate
        locationDetector.delegate = self as LocationDetectorDelegate
        fetchStation()
        MBProgressHUD.showAdded(to: self.view, animated:true)
    }
    
    private func fetchStation(){
        locationDetector.findLocation()
    }
 // show all the information we need on screen
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationsTableViewCell
        
        let station = stations[indexPath.row]
        
        cell.StationLabel.text = station.name
        //cell.LaiLabel.text = String(station.Lat)
        //cell.LonLabel.text = String(station.Lon)
        
        
        return cell
    }
    //Using segue to pass data to next viewcontroller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you select: \(indexPath.row)")
       
        performSegue(withIdentifier: "LandmarksSegue", sender: indexPath.row)
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let row = sender as! Int
            let destinationVC = segue.destination as! LandmarksViewController
             destinationVC.station = stations[row]
        
    }
    }
extension MetroStationsViewController: LocationDetectorDelegate {
    
    func locationDetected(latitude: Double, longitude: Double) {
        print("found")
        wmataapimanager.fetchStations(longitude: longitude, latitude: latitude)
        userLatitude = latitude
        userLongitude = longitude
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            //TODO: Show a AlertController with error
        }
    }
}

extension MetroStationsViewController: FetchStationsDelegate{
   //Using CLLocation to calculate the distance between current location and each station, and then sort them
    func findDistance(){
        let userLocation = CLLocation(latitude: userLatitude, longitude: userLongitude)
        
        for i in 0..<stations.count{
            let stationsLocation = CLLocation(latitude: stations[i].lat, longitude: stations[i].lon)
            stations[i].stationDistance = userLocation.distance(from: stationsLocation)
        }
        stations = stations.sorted(by: { $0.stationDistance <= $1.stationDistance})
    }
   
    func stationsFound(_ stations: [Station]) {
        DispatchQueue.main.async {
            self.stations = stations
            self.findDistance()
            MBProgressHUD.hide(for: self.view, animated: true)
    }
    }
    func stationsNotFound(reason: WmataAPIManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let alertController = UIAlertController(title: "Problem fetching landmark", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchStation()
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
