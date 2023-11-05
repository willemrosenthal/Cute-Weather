//
//  WeatherData.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/5/23.
//

import Foundation

class AccessDataModel: ObservableObject {
    @Published var locationName: String = "XXX"
    @Published var weatherData: WeatherData?
}

struct WeatherDataManager {
    var accessDataModel: AccessDataModel?
    var weatherData: WeatherData?
    var locationName: String = ""
    
    init () {
        
    }
    
    mutating func assignAccessData(_ accessDataModel: AccessDataModel) {
        self.accessDataModel = accessDataModel
    }
    
    mutating func updateWeatherData(data: WeatherData, loc: String) {
        weatherData = data;
        locationName = loc;
        self.accessDataModel?.locationName = loc;
        self.accessDataModel?.weatherData = data;
        print("updated data:")
        print("locationName: \(locationName)")
//        print(weatherData)
    }
    func getDailyTemp (dayNo: Int) -> Int {
       return Int(round(weatherData?.daily[dayNo].temp.day ?? 0.0))
    }
    func getHigh (dayNo: Int) -> Int {
        return Int(round(weatherData?.daily[dayNo].temp.max ?? 0.0))
    }
    func getLow (dayNo: Int) -> Int {
        return Int(round(weatherData?.daily[dayNo].temp.min ?? 0.0))
    }
    func getDailyWeather (dayNo: Int) -> String {
        return weatherData?.daily[dayNo].weather[0].main ?? ""
    }
    
    func getWeatherIcon (dayNo: Int, hourly: Bool = false) -> String {
        if (hourly) {
            return weatherData?.hourly[0].weather[0].icon ?? ""
        }
        return weatherData?.daily[dayNo].weather[0].icon ?? ""
    }
    
    func getCurrentDescription () -> String {
        return weatherData?.current.weather[0].description ?? ""
    }
    func getCurrentWeather () -> String {
        return weatherData?.current.weather[0].main ?? ""
    }
    func getCurrentTemp () -> Int {
        return Int(round(weatherData?.current.temp ?? 0.0))
    }
    func getCurrentWeatherIcon () -> String {
        return weatherData?.current.weather[0].icon ?? ""
    }
}
