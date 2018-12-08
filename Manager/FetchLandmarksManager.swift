//
//  FetchLandmarksManager.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/7.
//  Copyright © 2018 zkxd. All rights reserved.
//

/*import Foundation

protocol FetchGymsDelegate {
    func landmarksFound(_ landmarks: [LandmarkResponse])
    func gymsNotFound(reason: Fetch.FailureReason)
}
class FourSquareAPIManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    
    
    func getLandMarks(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_secret", value: "W5yBocKSm1VFHOIB1zqj3Ovv0UNpN1_WM9jPScCoymBbdc6QDxhRfueAj4fdS7mT_J7jXwK4nyvt27r_gt8u3gDSkdsLyTQEfaU_dSxYinyG-aBF7n1wNQ3CWwMLXHYx"),
            
            URLQueryItem(name: "ll", value: "\(latitude), \(longitude)"),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            
            guard let response = response as? HTTPURLResponse else {
                
                self.delegate?.gymsNotFound(reason: .noResponse)
                
                return
            }
            
            guard response.statusCode == 200 else {
                self.delegate?.gymsNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                self.delegate?.gymsNotFound(reason: .noData)
                
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let fourSquareResponse = try decoder.decode(FourSquareResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var gyms = [Gym]()
                
                for venue in fourSquareResponse.response.venues {
                    let address = venue.location.formattedAddress.joined(separator: " ")
                    
                    let iconPrefix = venue.categories.first?.icon.prefix
                    let iconSuffix = venue.categories.first?.icon.suffix
                    
                    var iconUrl: String? = nil
                    
                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
                    }
                    
                    let gym = Gym(name: venue.name, address: address, iconUrl: iconUrl)
                    
                    gyms.append(gym)
                }
                
                //now what do we do with the gyms????
                self.delegate?.gymsFound(gyms)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print(error.localizedDescription)
                
                self.delegate?.gymsNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
*/
