//
//  CityWeatherApp.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import SwiftUI

@main
struct CityWeatherApp: App {
    
    @StateObject private var router = AppRouter()
    @StateObject private var model = WeatherModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(model)
                .environmentObject(router)
        }
    }
}
