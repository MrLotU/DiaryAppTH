//
//  LocationManager.swift
//  Today
//
//  Created by Jari Koopman on 24/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var onLocationFix: ((CLPlacemark?, NSError?) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        
        getPermission()
    }
    
    fileprivate func getPermission() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unresolved error  \(error), \(error._userInfo.debugDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let onLocationFix = self.onLocationFix {
                onLocationFix(placemarks?.first, error as NSError?)
            }
        }
        
        
    }
}

