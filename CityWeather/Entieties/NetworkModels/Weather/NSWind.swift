//
//  Wind.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSWind: Codable {
    
    var speed: Float
    var gust: Float
    var degree: Int16
    
    private enum CodingKeys: String, CodingKey {
        case speed
        case gust
        case degree = "deg"
    }
}
