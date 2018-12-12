//
//  FetchLandmarksManager.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/7.
//  Copyright © 2018 zkxd. All rights reserved.
//

import Foundation

protocol FetchLandMarksDelegate {
    func landmarkFound(_ landmarks: [Landmark])
    func landmarkNotFound(reason:FetchLandmarksManager.FailureReason)
}
//fetch landmark data by passing several parameters
class FetchLandmarksManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    var delegate: FetchLandMarksDelegate?
    
    func fetchLandMarks(latitude: Double, longitude: Double) {
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "categories", value: "landmarks"),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer W5yBocKSm1VFHOIB1zqj3Ovv0UNpN1_WM9jPScCoymBbdc6QDxhRfueAj4fdS7mT_J7jXwK4nyvt27r_gt8u3gDSkdsLyTQEfaU_dSxYinyG-aBF7n1wNQ3CWwMLXHYx", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            
            guard let response = response as? HTTPURLResponse else {
                
                self.delegate?.landmarkNotFound(reason: .noResponse)
                
                return
            }
            
            guard response.statusCode == 200 else {
                print("response is nil or not 200")
                self.delegate?.landmarkNotFound(reason: .non200Response)
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data
                else {
                    print("data is nil")
                    self.delegate?.landmarkNotFound(reason: .noData)
                    
                    return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
  // get all those information
            do {
                print("start do")
                let landmarkResponse = try decoder.decode(LandmarkResponse.self, from: data)
                
                
                var landmarks = [Landmark]()
                
                for landmark in landmarkResponse.businesses{
                    let landmark = Landmark(name: landmark.name,rating:landmark.rating, address: landmark.location.address1,imageUrl:landmark.imageUrl,id:landmark.id,lon:landmark.coordinates.latitude,lat:landmark.coordinates.longitude)
                    landmarks.append(landmark)
                }
                //print(landmarks)
                self.delegate?.landmarkFound(landmarks)
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.landmarkNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
