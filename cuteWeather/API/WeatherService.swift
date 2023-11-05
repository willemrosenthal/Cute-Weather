//
//  WeatherService.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import Foundation

struct WeatherQueryData {
    var API_KEY = "e61be2cfb8b15f9a16c18322e2664937"
    var LAT = 50.1947
    var LON = -70.3562
    var UNITS = "imperial"
    var PART = "minutely"

    mutating func setQueryData(lat: Double, lon: Double, units: String, part: String) {
        LAT = lat
        LON = lon
        UNITS = units
        PART = part
    }

    var urlString: String {
        print("in urlString: \(LAT), \(LON)")
        return "https://api.openweathermap.org/data/2.5/onecall?lat=\(LAT)&lon=\(LON)&units=\(UNITS)&exclude=\(PART)&appid=\(API_KEY)"
    }
}

extension URLSession {
    func fetchData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let url = URL(string: queryData.urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(.success(weatherData))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}

var queryData = WeatherQueryData()

class WeatherFetcher: YourLocationManagerDelegate {
    let locationManager = YourLocationManager()

    init() {
        locationManager.delegate = self
    }
    
    func requestCurrentWeatherData() {
        print("requestCurrentWeatherData() > start")
        // Check if the location manager has a valid location
        guard let location = locationManager.locationManager.location else {
          print("Location data is not available.")
          return
        }
        
        print("requestCurrentWeatherData() > assign lat and lon")
        // Extract the latitude and longitude from the location object
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Use the latitude and longitude to create a WeatherQueryData object
        updateWeatherQueryData(lat: latitude, lon: longitude)
        
        // Fetch weather data using the WeatherQueryData
        fetchWeatherData { result in
          switch result {
          case .success(let weatherData):
              // Handle the successful result (weatherData)
              weatherDataManager.updateWeatherData(data: weatherData, loc: self.locationManager.currentLocationName)
              print ("got weatherData: requestCurrentWeatherData()")
//              print(weatherData)
          case .failure(let error):
              // Handle the error
              print("Error: \(error)")
          }
        }
    }

    // Implement YourLocationManagerDelegate method
    func locationManager(_ manager: YourLocationManager, didUpdateLocationWithLat lat: Double, lon: Double, locationName: String) {
        print ("WeatherFetcher > locationManager()")
        // Use the updated latitude and longitude in your WeatherQueryData
        updateWeatherQueryData(lat: lat, lon: lon)

        // Fetch weather data with the updated query data
        fetchWeatherData { result in
            switch result {
            case .success(let weatherData):
                // Handle the successful result (weatherData)
                weatherDataManager.updateWeatherData(data: weatherData, loc: self.locationManager.currentLocationName)
                print ("got weatherData: locationManager()")
//                print(weatherData)
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }

    // Update WeatherQueryData with new latitude and longitude
    func updateWeatherQueryData(lat: Double, lon: Double) {
        queryData.setQueryData(lat: lat, lon: lon, units: "imperial", part: "minutely")
    }

    func fetchWeatherData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
        print ("WeatherFetcher > fetchWeatherData()")
        URLSession.shared.fetchData { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weatherData):
                // Handle the successful result (weatherData)
                completion(.success(weatherData))
                print("weather data fetched")
//                print(weatherData)
            case .failure(let error):
                // Handle the error
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
    }
}
