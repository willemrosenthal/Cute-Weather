//
//  HandleLocation.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import Foundation
import CoreLocation

protocol YourLocationManagerDelegate: AnyObject {
    func locationManager(_ manager: YourLocationManager, didUpdateLocationWithLat lat: Double, lon: Double, locationName: String)
}

class YourLocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var currentLocationName = ""
    weak var delegate: YourLocationManagerDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Request "When In Use" permission
        locationManager.startUpdatingLocation() // Start location updates
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("YourLocationManager > locationManager() > start")
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            // Create a CLLocation object with the current coordinates
            let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
            
            
            print("YourLocationManager > locationManager() > get loc name")
            
            // Use a CLGeocoder to reverse geocode the coordinates
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                if let placemark = placemarks?.first {
                    if let locality = placemark.locality, let administrativeArea = placemark.administrativeArea {
                        let locationName = "\(locality), \(administrativeArea)"
                        
                        print ("got loc name: \(locationName)")
                        // update loc name
                        weatherDataManager.updateLocName(loc: locationName)
                        
                        // Store the location name
                        self.currentLocationName = locationName

                        // Call the delegate method with the updated latitude, longitude, and location name
                        self.delegate?.locationManager(self, didUpdateLocationWithLat: latitude, lon: longitude, locationName: locationName)
                    }
                }
            }
//            // Call the delegate method with the updated latitude and longitude
//            delegate?.locationManager(self, didUpdateLocationWithLat: latitude, lon: longitude)

            // Stop updating location if you only need a single location
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle errors if any
        print("Location manager error: \(error.localizedDescription)")
    }
}

