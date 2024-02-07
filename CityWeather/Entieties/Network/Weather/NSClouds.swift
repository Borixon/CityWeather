//
//  Clouds.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSClouds: Codable {
    
    var coverage: Int8
    
    private enum CodingKeys: String, CodingKey {
        case coverage = "all"
    }
}

extension Int8 {
    var asInt: Int {
        Int(self)
    }
}
