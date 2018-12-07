//
//  LocationDetector.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/6.
//  Copyright © 2018 zkxd. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double)
    func locationNotDetected()
}

class LocationDetector: NSObject {
    let locationManager = CLLocationManager()
    
    var delegate: LocationDetectorDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self as CLLocationManagerDelegate
    }
    
func findLocation() {
    let permissionStatus = CLLocationManager.authorizationStatus()
    
    switch(permissionStatus) {
        
    case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
    case .restricted:
        delegate?.locationNotDetected()
    case .denied:
        delegate?.locationNotDetected()
    case .authorizedAlways:
        break
    case .authorizedWhenInUse:
        locationManager.requestLocation()
    }
   }
}

extension LocationDetector: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //do something with the location
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            print("latitude=\(location.coordinate.latitude).longitude=\(location.coordinate.longitude)")
            delegate?.locationDetected(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
        delegate?.locationNotDetected()
    }
    
    //this gets called after user accepts OR denies permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //handle this
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            delegate?.locationNotDetected()
        }
    }
    
}
