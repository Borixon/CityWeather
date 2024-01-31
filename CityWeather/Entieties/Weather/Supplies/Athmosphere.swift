//
//  Weather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct Athmosphere: Codable {
    
    var temperature: Float
    var tempSensed: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Int16
    var humidity: Int16
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case tempSensed = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}
