//
//  WmataAPIManager.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/2.
//  Copyright © 2018 zkxd. All rights reserved.
//

import Foundation

protocol FetchStationsDelegate {
    func stationsFound(_ stations: [Station])
    func stationsNotFound(reason: WmataAPIManager.FailureReason)
}

class WmataAPIManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    var delegate: FetchStationsDelegate?
    
    func fetchStations(longitude:Double,latitude:Double) {
        var urlComponents = URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "87687bf5213242b7830ae98dec06868f"),
            URLQueryItem(name: "ll", value: "\(latitude), \(longitude)"),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            
            guard let response = response as? HTTPURLResponse else {
                
                self.delegate?.stationsNotFound(reason: .noResponse)
                
                return
            }
            
            guard response.statusCode == 200 else {
                self.delegate?.stationsNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                self.delegate?.stationsNotFound(reason: .noData)
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let wmataResponse = try decoder.decode(WmataResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var stations = [Station]()
                
                for station in wmataResponse.Stations
                {
                    
                   /* let iconPrefix = venue.categories.first?.icon.prefix
                    let iconSuffix = venue.categories.first?.icon.suffix
                    
                    var iconUrl: String? = nil
                    
                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
                    }
                    */
                    let station = Station(name: station.Name)
                    
                    stations.append(station)
                }
                
                //now what do we do with the gyms????
                
                self.delegate?.stationsFound(stations)
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print(error.localizedDescription)
                
                self.delegate?.stationsNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
