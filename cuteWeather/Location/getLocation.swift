//
//  getLocation.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//
//
//import Foundation
//import CoreLocation

//class YourLocationManager: NSObject, CLLocationManagerDelegate {
//    weak var delegate: LocationManagerDelegate?
//    let locationManager = CLLocationManager()
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization() // Request "When In Use" permission
//        locationManager.startUpdatingLocation() // Start location updates
//        print("YourLocationManager initialized")
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations called")
//        if let location = locations.last {
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude
//            
//            
//            print("Location update received")
//            print("USER LOC: Latitude: \(latitude), Longitude: \(longitude)")
//
//            // Stop updating location if you only need a single location
//            locationManager.stopUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        // Handle errors if any
//        print("Location manager error: \(error.localizedDescription)")
//    }
//}

import Foundation
import CoreLocation

protocol YourLocationManagerDelegate: AnyObject {
    func locationManager(_ manager: YourLocationManager, didUpdateLocationWithLat lat: Double, lon: Double)
}

class YourLocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    weak var delegate: YourLocationManagerDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Request "When In Use" permission
        locationManager.startUpdatingLocation() // Start location updates
        print("init for loc")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("loc manager start")
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("loc lat and lon")

            // Call the delegate method with the updated latitude and longitude
            delegate?.locationManager(self, didUpdateLocationWithLat: latitude, lon: longitude)

            // Stop updating location if you only need a single location
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle errors if any
        print("Location manager error: \(error.localizedDescription)")
    }
}

