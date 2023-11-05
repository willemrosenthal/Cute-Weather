//
//  ContentView.swift
//  cuteWeather
//
//  Created by Willem Rosenthal on 11/4/23.
//

import SwiftUI

func fetchLocationAndWeather() {
    let weatherFetcher = WeatherFetcher()
    print("here")
    // Implement the logic to request current weather data
    weatherFetcher.requestCurrentWeatherData()
}

struct ContentView: View {

    var body: some View {
        VStack {
            // Your UI components

            Button("Fetch Weather Data") {
                print("Button Pressed")
                fetchLocationAndWeather()
            }
        }
    }
}

#Preview {
    ContentView()
}


//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
