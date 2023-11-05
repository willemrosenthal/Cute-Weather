//
//  Days.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import Foundation

// app should let you set this yourself
let birthdayMonth = 8;
let birthdayDay = 9;
let birthdayIcon = "birthday";

var holidayTable = [String: Any]()

func buildHolidays() {
    holidayTable["1,1"] = "newyearsday"

    holidayTable["2,14"] = "valentine"

    holidayTable["3,17"] = "patrick"
    holidayTable["3,20"] = "spring"

    holidayTable["4,1"] = "fool"
    holidayTable["4,9"] = "easter"

    holidayTable["5,14"] = "mother"
    holidayTable["5,18"] = "dad"

    holidayTable["6,21"] = "summer"

    holidayTable["9,22"] = "autumn"

    holidayTable["10,31"] = "halloween"

    holidayTable["11,24"] = "thanksgiving"

    holidayTable["12,21"] = "winter"
    holidayTable["12,25"] = "christmas"
    holidayTable["12,31"] = "newyears"
}

let datesManager = Dates()

struct Dates {
    var currentDate = Date();
    var calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    init() {
        updateDate();
        buildHolidays();
    }
    
    
    mutating func updateDate() {
        currentDate = Date();
        calendar = Calendar.current
    }
    
    func getDayFromTime (timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        dateFormatter.dateFormat = "E" // "E" represents the day of the week abbreviation
        return dateFormatter.string(from: date)
    }
    
    func getMonth() -> Int {
        return calendar.component(.month, from: currentDate)
    }
    
    func getDay() -> Int {
        return calendar.component(.day, from: currentDate)
    }
    
    // may not be used
    func getDayOfTheWeek() -> String {
        dateFormatter.dateFormat = "EEEE"
        var dayName = dateFormatter.string(from: currentDate)
        dayName = String(dayName.prefix(3))
        return dayName.capitalized
    }
    
    func getMonthName() -> String {
        dateFormatter.dateFormat = "MMMM"
        var monthName = dateFormatter.string(from: currentDate)
        monthName = String(monthName.prefix(3))
        return monthName.capitalized
    }
    
    func birthdayCheck () -> Bool {
        //const date = new Date((todayUnixTimeZoned) * 1000);
        //console.log("hour "+ date.getHours()+" tz: "+weatherData.timezone_offset);
        print("current: \(getMonth()) bMonth: \(birthdayMonth-1) currentDay: \(getDay()) bDay: \(birthdayDay)")
        return (getMonth() == (birthdayMonth-1) && getDay() == birthdayDay);
    }
    
    func holidayCheck() -> String {
        let _day = getDay()
        let _month = getMonth() + 1 // add 1 because January starts at 0

        // Check holidays
        if let holiday = holidayTable["\(_month),\(_day)"] as? String {
            print("Holiday today: \(holiday)")
            return holiday
        } else {
            print("No holiday found")
            return "none"
        }
    }
}
