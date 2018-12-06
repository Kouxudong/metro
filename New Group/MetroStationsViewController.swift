//
//  MetroStationsViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/11/29.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit
//import MBProgressHUD

class MetroStationsViewController: UITableViewController{
    let wmataapimanager = WmataAPIManager()
    
    var stations = [Station](){
        didSet{
            tableView.reloadData()
        }
    }
   
    override func viewDidLoad(){
        super.viewDidLoad()
        wmataapimanager.delegate = self as FetchStationsDelegate
        wmataapimanager.fetchStations()
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        
        let station = stations[indexPath.row]
        
        cell.StationLabel.text = station.name
        
        
        
        return cell
    }
    
}

extension MetroStationsViewController: FetchStationsDelegate{
    func stationsFound(_ stations: [Station]) {
        print("station found")
    }
    
    func stationsNotFound() {
        print("station not found")
    }
    
    
}
