//
//  WmataResponse.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/2.
//  Copyright © 2018 zkxd. All rights reserved.
//

import Foundation

struct WmataResponse: Codable {
    
    let meta: Meta
    let response: Response
    
}

struct Meta: Codable {
    
    let code: Int
    let requestId: String
    
}

struct Response: Codable {
    
    let stations: [Stations]
    
}

struct Stations: Codable {
    
    
    let name: String
   /* let StationTogether1: String
    let LineCode1: String
    let Lat: Float
    let Code: String
    let Lon: Float
    let Address: [Address]*/
    
}

/*struct Address: Codable {
    
    let Street: String?
    let City: String
    let State: String
    let Zip: Int
   
    
}*/


