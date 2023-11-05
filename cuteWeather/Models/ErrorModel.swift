//
//  errorModel.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import Foundation

struct WeatherResonseStatus: Decodable {
    let status: WeatherError
}

struct WeatherError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}

// AM I UsiNG THIS>?
