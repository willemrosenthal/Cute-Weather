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
        Text(getDayString(dayNo: dayNum))
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
    let dateString = getCurrentDateString();
    
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

func getCurrentDateString() -> String {
    return "\(datesManager.getCurrentDayOfTheWeek())  \(datesManager.getCurrentMonth()) \(datesManager.getDayOfTheMonth())"
}

func getDayString(dayNo: Int) -> String {
    return "\(weatherDataManager.getOrderedDayTitle(dayNo: dayNo))"
}

struct DayWeatherData {
    let dayNo: Int
    let day: String
    let temp: Int
    let icon: String
    let low: Int?
    let high: Int?
    let description: String?
}

struct ViewData {
    let date: String
    let location: String
    let days: [DayWeatherData]
}

// build the view data we'll need to pass along for dispaly
func getWeatherData() -> ViewData {
    var days = [DayWeatherData]()
    // get tiny days
    for i in 0...4 {
        let dayNo: Int = Int(i)
        let dayName: String = getDayString(dayNo: Int(i))
        let dayTemp: Int = weatherDataManager.getDailyTemp(dayNo: Int(i))
        let dayIcon: String = getWeatherImage(day: i)
        let day = DayWeatherData(dayNo: dayNo, day: dayName, temp: dayTemp, icon: dayIcon, low: 0, high: 0, description: "")
        days.append(day)
    }
    // get big day
    let mainDayName:String = getDayString(dayNo: 0)
    let currentTemp:Int = weatherDataManager.getCurrentTemp()
    let mainIcon:String = getWeatherImage(day: datesManager.getDayOfTheMonth(), hourly: true)
    let low:Int = weatherDataManager.getLow(dayNo:0)
    let high:Int = weatherDataManager.getHigh(dayNo:0)
    let description: String = weatherDataManager.getCurrentDescription()
    
    let mainDay = DayWeatherData(dayNo: 0, day: mainDayName, temp: currentTemp, icon: mainIcon, low: low, high: high, description: description)
    days.append(mainDay)
    
    let date:String = getCurrentDateString()
    let loc:String = weatherDataManager.locationName
    
    let viewData:ViewData = ViewData(date: date, location: loc, days: days)
    return viewData
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
