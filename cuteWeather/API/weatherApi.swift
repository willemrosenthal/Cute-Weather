//
//  weatherApi.swift
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
        print("in setQueryData: \(lat), \(lon)")
        LAT = lat
        LON = lon
        UNITS = units
        PART = part
        print("end setQueryData: \(LAT), \(LON)")
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
        // Check if the location manager has a valid location
        guard let location = locationManager.locationManager.location else {
          print("Location data is not available.")
          return
        }

        // Extract the latitude and longitude from the location object
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        print("lat: \(latitude), lon: \(longitude)")

        // Use the latitude and longitude to create a WeatherQueryData object
        updateWeatherQueryData(lat: latitude, lon: longitude)
        
        // Fetch weather data using the WeatherQueryData
        fetchWeatherData { result in
          switch result {
          case .success(let weatherData):
              // Handle the successful result (weatherData)
              print(weatherData)
          case .failure(let error):
              // Handle the error
              print("Error: \(error)")
          }
        }
    }

    // Implement YourLocationManagerDelegate method
    func locationManager(_ manager: YourLocationManager, didUpdateLocationWithLat lat: Double, lon: Double) {
        // Handle location update
        print("Location update received")
        print("Latitude: \(lat), Longitude: \(lon)")

        // Use the updated latitude and longitude in your WeatherQueryData
        updateWeatherQueryData(lat: lat, lon: lon)

        // Fetch weather data with the updated query data
        fetchWeatherData { result in
            switch result {
            case .success(let weatherData):
                // Handle the successful result (weatherData)
                print(weatherData)
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
        URLSession.shared.fetchData { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weatherData):
                // Handle the successful result (weatherData)
                completion(.success(weatherData))
                print(weatherData)
            case .failure(let error):
                // Handle the error
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
    }
}


//func fetchWeatherData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
//    URLSession.shared.fetchData { (result: Result<WeatherData, Error>) in
//        switch result {
//        case .success(let weatherData):
//            // Handle the successful result (weatherData)
//            completion(.success(weatherData))
//            print(weatherData)
//        case .failure(let error):
//            // Handle the error
//            completion(.failure(error))
//            print("Error: \(error)")
//        }
//    }
//}


/*
class WeatherFetcher {
    let locationManager = YourLocationManager() // Create an instance of YourLocationManager
    var locationCompletion: ((Double?, Double?) -> Void)?
    
//    func requestCurrentWeatherData() {
//        // Call the location manager to get the updated location
//        locationUpdateCompletion { [weak self] lat, lon in
//            if let lat = lat, let lon = lon {
//                // Use the updated latitude and longitude in your WeatherQueryData
//                self?.updateWeatherQueryData(lat: lat, lon: lon)
//                
//                // Now, you can fetch weather data with the updated query data
//                self?.fetchWeatherData()
//            }
//        }
//    }
    func requestCurrentWeatherData() {
        // Call the location manager to get the updated location
        print("in requestCurrentWeatherData()");
        locationUpdateCompletion { [weak self] lat, lon in
            print("got here");
            if let lat = lat, let lon = lon {
                // Use the updated latitude and longitude in your WeatherQueryData
                self?.updateWeatherQueryData(lat: lat, lon: lon)
                
                // Now, you can fetch weather data with the updated query data
                self?.fetchWeatherData(completion: { result in
                    switch result {
                    case .success(let weatherData):
                        // Handle the successful result (weatherData)
                        print(weatherData)
                    case .failure(let error):
                        // Handle the error
                        print("Error: \(error)")
                    }
                })
            }
        }
    }
    
    func locationUpdateCompletion(completion: @escaping (Double?, Double?) -> Void) {
        print("in locationUpdateCompletion()")
        // You can access the latitude and longitude here
        locationCompletion = completion
    }
    
    // Update WeatherQueryData with new latitude and longitude
    func updateWeatherQueryData(lat: Double, lon: Double) {
        var queryData = WeatherQueryData()
        queryData.setQueryData(lat: lat, lon: lon, units: "imperial", part: "minutely")
    }
    func fetchWeatherData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
        URLSession.shared.fetchData { (result: Result<WeatherData, Error>) in
            switch result {
            case .success(let weatherData):
                // Handle the successful result (weatherData)
                completion(.success(weatherData))
                print(weatherData)
            case .failure(let error):
                // Handle the error
                completion(.failure(error))
                print("Error: \(error)")
            }
        }
    }
}
 */


//    func fetchWeatherData() {
//        // Use the updated query data to fetch weather data
//        if let url = URL(string: queryData.urlString) {
//            URLSession.shared.fetchData(at: url) { (result: Result<WeatherData, Error>) in
//                switch result {
//                case .success(let weatherData):
//                    // Handle the successful result (weatherData)
//                    print(weatherData)
//                case .failure(let error):
//                    // Handle the error
//                    print("Error: \(error)")
//                }
//            }
//        }
//    }


//extension URLSession {
//  func fetchData(at url: URL, completion: @escaping (Result<[ToDo], Error>) -> Void) {
//    self.dataTask(with: url) { (data, response, error) in
//      if let error = error {
//        completion(.failure(error))
//      }
//
//      if let data = data {
//        do {
//          let toDos = try JSONDecoder().decode([ToDo].self, from: data)
//          completion(.success(toDos))
//        } catch let decoderError {
//          completion(.failure(decoderError))
//        }
//      }
//    }.resume()
//  }
//}

// EXAMPLE FETCH
// https://api.openweathermap.org/data/3.0/onecall?lat=${LAT}&lon=${LON}&units=${UNITS}&exclude=${PART}&appid=${API_KEY}
// https://api.openweathermap.org/data/3.0/onecall?lat=42.1947&lon=-73.3562&units=imperial&exclude=minutely&appid=e61be2cfb8b15f9a16c18322e2664937



//struct WeatherData:

//func getTemp (_ dayNo: Int) -> Int {
//    return round(weatherData.daily[dayNo].temp.day);
//}
//const getHigh = (dayNo) => {
//    return Math.round(weatherData.daily[dayNo].temp.max);
//}
//const getLow = (dayNo) => {
//    return Math.round(weatherData.daily[dayNo].temp.min);
//}
//const getWeather = (dayNo) => {
//    return weatherData.daily[dayNo].weather[0].main;
//}
