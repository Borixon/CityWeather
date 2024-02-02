//
//  Weather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSCityWeather: Codable {
    var list: Array<NSWeatherStamp>
    var city: NSCity
    
    var daysData: Array<Any> {
        [""]
    }
}
