//
//  PersistenceManager.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/10.
//  Copyright © 2018 zkxd. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    
    let favoritesKey = "favorites"
    func saveFavorite(landmarks: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var favorites = fetchWorkouts()
        
       if favorites.contains(where: { $0.id == "\(landmarks.id)"}){
            if let index = favorites.firstIndex(where: {$0.id == "\(landmarks.id)"}){
                favorites.remove(at: index)
            }
       }else{
        favorites.append(landmarks)
        }
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(favorites)
        
        userDefaults.set(encodedWorkouts, forKey: favoritesKey)
    }
    
    func check(landmarks: Landmark) -> Bool{
        let favorites = fetchWorkouts()
        if favorites.contains(where: { $0.id == "\(landmarks.id)"}){
            
            return true
        }else{
            return false
        }
    }

    func fetchWorkouts() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let workoutData = userDefaults.data(forKey:favoritesKey), let workouts = try? JSONDecoder().decode([Landmark].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
            
        else {
            return [Landmark]()
        }
    }
    
  
}

