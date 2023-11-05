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
            .frame(width: screenWidth * percentageOfScreenWidth, height: 200)
            .cornerRadius(20)
        }
}

func makeSmallDay(dayNum: Int) -> some View {
    let iconName = getWeatherImage(day: dayNum)
    
    return VStack {
        Text("\(weatherDataManager.getOrderedDayTitle(dayNo: dayNum))")
            .font(.system(size: 14))
            .foregroundColor(Color.white)
        Image(iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40) // Adjust the size
        Text("\(weatherDataManager.getDailyTemp(dayNo: dayNum))°")
            .font(.system(size: 14))
            .foregroundColor(Color.white)
    }
}

func makeDateAndIconBlock() -> some View {
    let iconName = getWeatherImage(day: datesManager.getDayOfTheMonth(), hourly: true)
    let dateString = "\(datesManager.getCurrentDayOfTheWeek())  \(datesManager.getCurrentMonth()) \(datesManager.getDayOfTheMonth())";
    
    return VStack {
        Text(dateString)
            .font(.system(size: 14))
            .foregroundColor(Color.white)
        Image(iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 83, height: 83)
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
                    HStack {
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
                        }
                        VStack {
                            makeDateAndIconBlock()
                        }
                    }
                    HStack {
                        Spacer()
                        Spacer()
                        Spacer()
//                        Text("\(weatherDataManager.getOrderedDayTitle(dayNo: 0))")
//                            .font(.system(size: 14))
//                            .foregroundColor(Color.white)
//                        
                        makeSmallDay(dayNum: 0)
                        Spacer()
                        makeSmallDay(dayNum: 1)
                        Spacer()
                        makeSmallDay(dayNum: 2)
                        Spacer()
                        makeSmallDay(dayNum: 3)
                        Spacer()
                        makeSmallDay(dayNum: 4)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
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
