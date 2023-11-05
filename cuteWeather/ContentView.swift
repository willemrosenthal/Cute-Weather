//
//  ContentView.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import SwiftUI

func fetchLocationAndWeather() {
    let weatherFetcher = WeatherFetcher()
    // Implement the logic to request current weather data
    weatherFetcher.requestCurrentWeatherData()
}

let dates = Dates()
var weatherDataManager = WeatherDataManager()

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct MainWeatherBox: View {
    let percentageOfScreenWidth = 0.9
    var body: some View {
        Rectangle()
            .fill(Color.purple)
            .frame(width: screenWidth * percentageOfScreenWidth, height: 150)
            .cornerRadius(20)
        }
}

struct ContentView: View {
    @ObservedObject var dataModel = AccessDataModel()
    
    init() {
        weatherDataManager.assignAccessData(dataModel) 
        fetchLocationAndWeather()
    }

    var body: some View {
        ZStack {
            Color.blue.opacity(0.5)
            ZStack {
                HStack {
                    MainWeatherBox()
                }
                VStack {
                    Text(weatherDataManager.locationName)
                        .font(.system(size: 14))
                        .foregroundColor(Color.white)
//                    Text("\(weatherDataManager.getDailyTemp(dayNo:0))°")
                    Text("\(weatherDataManager.getCurrentTemp())°")
                        .font(.system(size: 40))
                        .foregroundColor(Color.white)
                    Text("L:\(weatherDataManager.getLow(dayNo:0))°  H:\(weatherDataManager.getHigh(dayNo:0))°")
                        .font(.system(size: 10))
                        .foregroundColor(Color.white)
                    Text("\(weatherDataManager.getCurrentDescription())")
                        .font(.system(size: 10))
                        .foregroundColor(Color.white)
                }.ignoresSafeArea()
            }
            
        }//.padding()
//        VStack {
//            // Your UI components
//
//            Button("Fetch Weather Data") {
//                print("Button Pressed")
//                fetchLocationAndWeather()
//            }
//        }
    }
}

#Preview {
    ContentView()
}
