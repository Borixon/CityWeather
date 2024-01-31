//
//  Weather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct WeathersList: Codable {
    var list: Array<Weather>
    var city: City
}
