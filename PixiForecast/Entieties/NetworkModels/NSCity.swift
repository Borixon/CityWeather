//
//  City.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSCity: Codable {
    var name: String
    var country: String
    var sunrise: TimeInterval
    var sunset: TimeInterval
}
