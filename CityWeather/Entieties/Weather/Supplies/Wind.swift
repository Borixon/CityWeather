//
//  Wind.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct Wind: Codable {
    
    var speed: Float
    var gust: Float
    var degree: Int16
    
    enum CodingKeys: String, CodingKey {
        case speed
        case gust
        case degree = "deg"
    }
}
