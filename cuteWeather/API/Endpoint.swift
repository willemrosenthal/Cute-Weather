////
////  Endpoint.swift
////  cuteWeather
////
////  Created by Willem Rosenthal on 11/4/23.
////
//
//import Foundation
//
//
//var API_KEY = "e61be2cfb8b15f9a16c18322e2664937"
////var LAT = 42.1947
////var LON = -73.3562
////var UNITS = "imperial"
////var PART = "minutely"
////var APIURL = "https://api.openweathermap.org/data/3.0/onecall?lat=\(LAT)&lon=\(LON)&units=\(UNITS)&exclude=\(PART)&appid=\(API_KEY)";
//
//func getEndpoint(_ LAT:Double = 42.1947, LON:Double = -73.3562, UNITS: String = "imperial", PART: String = "minutely") -> String {
//    return "https://api.openweathermap.org/data/3.0/onecall?lat=\(LAT)&lon=\(LON)&units=\(UNITS)&exclude=\(PART)&appid=\(API_KEY)";
//}
//
//
//extension URLSession {
//    func fetchData(completion: @escaping (Result<WeatherData, Error>) -> Void) {
//        guard let url = URL(string: APIURL) else {
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
////
////
////enum Endpoint {
////    
////    case fetchCoins(url: String = "/v1/cryptocurrency/listings/latest")
////    
////    var request: URLRequest? {
////        guard let url = self.url else { return nil }
////        var request = URLRequest(url: url)
////        request.httpMethod = self.httpMethod
////        request.httpBody = self.httpBody
////        request.addValues(for: self)
////        return request
////    }
////    
////    private var url: URL? {
////        var components = URLComponents()
////        components.scheme = Constants.scheme
////        components.host = Constants.baseURL
////        components.port = Constants.port
////        components.path = self.path
////        components.queryItems = self.queryItems
////        return components.url
////    }
////    
////    private var path: String {
////        switch self {
////        case .fetchCoins(let url):
////            return url
////        }
////    }
////    
////    
////    private var queryItems: [URLQueryItem] {
////        switch self {
////        case .fetchCoins:
////            return [
////                URLQueryItem(name: "limit", value: "150"),
////                URLQueryItem(name: "sort", value: "market_cap"),
////                URLQueryItem(name: "convert", value: "CAD"),
////                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
////            ]
////        }
////    }
////    
////    
////    private var httpMethod: String {
////        switch self {
////        case .fetchCoins:
////            return HTTP.Method.get.rawValue
////        }
////    }
////    
////    private var httpBody: Data? {
////        switch self {
////        case .fetchCoins:
////            return nil
////        }
////    }
////}
////
////
////
////extension URLRequest {
////    
////    mutating func addValues(for endpoint: Endpoint) {
////        switch endpoint {
////        case .fetchCoins:
////            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
////            self.setValue(Constants.API_KEY, forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
////        }
////    }
////}
