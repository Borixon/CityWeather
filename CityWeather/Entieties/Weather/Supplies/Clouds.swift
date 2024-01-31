//
//  Clouds.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct Clouds: Codable {
    
    var coverage: Int8
    
    enum CodingKeys: String, CodingKey {
        case coverage = "all"
    }
}
