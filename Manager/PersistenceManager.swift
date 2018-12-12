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
    
    let workoutsKey = "workouts"
    
    func saveWorkout(landmarks: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var workouts = fetchWorkouts()
        workouts.append(landmarks)
        
        print(workouts)
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(workouts)
        
        userDefaults.set(encodedWorkouts, forKey: workoutsKey)
    }
    
    func fetchWorkouts() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        
        if let workoutData = userDefaults.data(forKey: workoutsKey), let workouts = try? JSONDecoder().decode([Landmark].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
            
        else {
            return [Landmark]()
        }
    }
    
  
}

