////
////  WeatherService.swift
////  cuteWeather
////
////  Created by Willem Rosenthal on 11/4/23.
////
//
//import Foundation
//
//enum WeatherServerError: Error {
//    case serverError(WeatherError)
//    case unknown(String = "An unknown error occurred.")
//    case decodingError(String = "Error parsing server response.")
//}
//
//class WeatherService {
//    static func fetchCoins(with endoint: Endpoint, completion: @escaping (Result<[WeatherData], WeatherServerError>)->Void) {
//        
//    }
//    
//    func fetchData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
//        guard let url = URL(string: getEndpoint()) else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//
//        self.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//            }
//
//            if let data = data {
//                do {
//                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                    completion(.success(weatherData))
//                } catch let decoderError {
//                    completion(.failure(decoderError))
//                }
//            }
//        }.resume()
//    }
//}
