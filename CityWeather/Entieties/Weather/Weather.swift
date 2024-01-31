//
//  TimeWeather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct Weather: Codable {
    
    var time: String
    var timeReadable: String
    var weather: [ReadableWeather]
    var athmosphere: Athmosphere
    var clouds: Clouds
    var wind: Wind
    var precipationProb: Float
    var visibility: Int16
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case timeReadable = "dt_txt"
        case athmosphere = "main"
        case clouds
        case weather
        case wind
        case precipationProb = "pop"
        case visibility
    }
}
