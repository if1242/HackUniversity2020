//
//  LocationManager.swift
//  HackAR
//
//  Created by viktor.volkov on 21.03.2020.
//  Copyright © 2020 viktor.volkov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    // MARK: - Variables
    
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    weak var delegate: CLLocationManagerDelegate? {
        didSet {
            locationManager.delegate = delegate
        }
    }
    
    func startScanning() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.startUpdatingLocation()
    }
}
