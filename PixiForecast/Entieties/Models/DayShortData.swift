//
//  DayShortData.swift
//  CityWeather
//
//  Created by Michał Krupa on 05/02/2024.
//

import Foundation

struct DayShortData: Identifiable {
    var id: TimeInterval
    var time: TimeInterval
    var day: String
    var date: String
    var tempMin: Float
    var tempMax: Float
    var pressure: Int16
    
    var tempAplitudeText: String {
        String(format: "%.1f-%.1f %@", tempMin, tempMax, AppData.unitSystem.tempUnit)
    }
    
    var pressureText: String {
        "\(pressure) \(AppData.unitSystem.pressureUnit)"
    }
}
