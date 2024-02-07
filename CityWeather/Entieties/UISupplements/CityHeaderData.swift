//
//  CityHeaderData.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import Foundation

struct CityHeaderData {
    
    internal let city: String
    internal let time: TimeInterval
    internal let castDescription: String?
    internal let icon: String?
    internal let temperature: Float?
    internal let sensedTemperature: Float?
    internal let sunrise: TimeInterval
    internal let sunset: TimeInterval
    
    var temperatureText: String {
        String(
            format: "%.1f %@",
            temperature ?? 0,
            AppData.unitSystem.tempUnit)
    }
    
    var timeDescription: String {
        "\(time.format(.time)) \(time.format(.date))"
    }
    
    var description: String? {
        guard let desc = castDescription else { return nil }
        return desc.prefix(1).capitalized + desc.dropFirst()
    }
    
    var sensedTempText: String {
        String(
            format: String(localized: "sensedTemperature"),
            sensedTemperature ?? 0,
            AppData.unitSystem.tempUnit)
    }
    
    var sunriseText: String {
        String(
            format: String(localized: "sunrise") + "\n%@",
            sunrise.format(.time))
    }
    
    var sunsetText: String {
        String(
            format: String(localized: "sunset") + "\n%@",
            sunset.format(.time))
    }
}
