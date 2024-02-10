//
//  TimeWeather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSWeatherStamp: Codable {
    
    var time: TimeInterval
    var timeReadable: String
    var weather: [NSWeatherReadable]
    var athmosphere: NSAthmosphere
    var clouds: NSClouds
    var wind: NSWind
    var precipation: Float
    var visibility: Int16
    
    private enum CodingKeys: String, CodingKey {
        case time = "dt"
        case timeReadable = "dt_txt"
        case athmosphere = "main"
        case clouds
        case weather
        case wind
        case precipation = "pop"
        case visibility
    }
}
