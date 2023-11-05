//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Decodable {
//    let lat, lon: Double
//    let timezone: String
//    let timezoneOffset: Int
//    let current: Current
//    let hourly: [Current]
//    let daily: [Daily]
//
//    enum CodingKeys: String, CodingKey {
//        case lat, lon, timezone
//        case timezoneOffset = "timezone_offset"
//        case current, hourly, daily
//    }
//}
//
//// MARK: - Current
//struct Current: Decodable {
//    let dt: Int
//    let sunrise, sunset: Int?
//    let temp, feelsLike: Double
//    let pressure, humidity: Int
//    let dewPoint, uvi: Double
//    let clouds, visibility: Int
//    let windSpeed: Double
//    let windDeg: Int
//    let windGust: Double
//    let weather: [Weather]
//    let pop: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case uvi, clouds, visibility
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, pop
//    }
//}
//
//// MARK: - Weather
//struct Weather: Decodable {
//    let id: Int
//    let main: Main
//    let description: Description
//    let icon: Icon
//}
//
//enum Description: String, Decodable {
//    case brokenClouds = "broken clouds"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case lightSnow = "light snow"
//    case moderateRain = "moderate rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//}
//
//enum Icon: String, Decodable {
//    case the02N = "02n"
//    case the03D = "03d"
//    case the03N = "03n"
//    case the04D = "04d"
//    case the04N = "04n"
//    case the10D = "10d"
//    case the13D = "13d"
//}
//
//enum Main: String, Decodable {
//    case clouds = "Clouds"
//    case rain = "Rain"
//    case snow = "Snow"
//}
//
//// MARK: - Daily
//struct Daily: Decodable {
//    let dt, sunrise, sunset, moonrise: Int
//    let moonset: Int
//    let moonPhase: Double
//    let summary: String
//    let temp: Double
//    let feelsLike: FeelsLike
//    let pressure, humidity: Int
//    let dewPoint, windSpeed: Double
//    let windDeg: Int
//    let windGust: Double
//    let weather: [Weather]
//    let clouds: Int
//    let pop, uvi: Double
//    let rain, snow: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, moonrise, moonset
//        case moonPhase = "moon_phase"
//        case summary, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, clouds, pop, uvi, rain, snow
//    }
//}
//
//// MARK: - FeelsLike
//struct FeelsLike: Decodable {
//    let day, night, eve, morn: Double
//}
