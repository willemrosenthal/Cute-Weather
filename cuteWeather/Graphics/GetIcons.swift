//
//  GetIcons.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/5/23.
//

import Foundation

func getWeatherImage( day: Int = 0, hourly: Bool = false ) -> String {
    var weatherString = "";
    var iconid = weatherDataManager.getWeatherIcon(dayNo: day, hourly: hourly)
    
    // get holiday icon (only if hourly is on)
    let holidayIcon = (hourly == true && day == 0) ? dates.holidayCheck() : "none";
    
    // get appropriate image
    if (dates.birthdayCheck() && day == 0 && hourly) {
        weatherString = birthdayIcon;
    }
    else if (holidayIcon != "none" && day == 0 && hourly ) { weatherString = holidayIcon}
    else if (iconid == "01d") { weatherString = "clear"}
    else if (iconid == "01n") {
        weatherString = "clear-night";
        let moonPhase: Double = weatherDataManager.weatherData?.daily[0].moon_phase ?? 0.0
        print("MOON PHASE: \(moonPhase)");
        if (day == 0 && hourly && moonPhase > 0.95) {
            weatherString = "full-moon";
        }
        else if (day == 0 && hourly && moonPhase < 0.05) {
            weatherString = "new-moon";
        }
    }
    else if (iconid == "02d" ) { weatherString = "part-cloud" }
    else if (iconid == "03d" || iconid == "04d") { weatherString = "cloudy" }
    else if (iconid == "02n" || iconid == "03n" || iconid == "04n" ) { weatherString = "cloudy-night" }
    else if (iconid == "09d" ) { weatherString = "heavy-rain" }
    else if (iconid == "09n" ) { weatherString = "heavy-rain" }
    else if (iconid == "10d" ) { weatherString = "rainy" }
    else if (iconid == "10n" ) { weatherString = "rainy-night" }
    else if (iconid == "11d") { weatherString = "storm" }
    else if (iconid == "11n") { weatherString = "storm" }
    else if (iconid == "13d") { weatherString = "snow" }
    else if (iconid == "13n") { weatherString = "snow" }
    else if (iconid == "50d") { weatherString = "windy" }
    else if (iconid == "50n") { weatherString = "windy" }

//    let weatherImagePath = imagesPath + "/" + weatherString + ".png";
//    // get the image
//    if (fm.fileExists(weatherImagePath)) {
//        fm.downloadFileFromiCloud(weatherImagePath);
//        let _image = fm.readImage( weatherImagePath)
//        return _image;
//    }
    return weatherString
}
