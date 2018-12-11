//
//  MenuViewController.swift
//  Metro Explorer
//
//  Created by tester on 2018/12/4.
//  Copyright © 2018 zkxd. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func SelectPressed(_ sender: UIButton) {
        print("select pressed")
        performSegue(withIdentifier: "stationsSegue", sender: self)
        
    }
    
    @IBAction func NearestPressed(_ sender: UIButton) {
        print("select pressed")
        performSegue(withIdentifier: "NearestStationsSegue", sender: self)    }
    @IBAction func FavoritesPressed(_ sender: UIButton) {
        print("select pressed")
        performSegue(withIdentifier: "FavoriteSegue", sender: self)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? LandmarksViewController
        if segue.identifier == "FavoriteSegue"{
            destinationVC?.fromFav = true
        }
    }
}
