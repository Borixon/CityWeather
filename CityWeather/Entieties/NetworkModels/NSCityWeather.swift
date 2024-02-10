//
//  Weather.swift
//  CityWeather
//
//  Created by Michał Krupa on 31/01/2024.
//

import Foundation

struct NSWeather: Codable, DBObject {
    typealias R = DBWeather
    
    var list: Array<NSWeatherStamp>
    var city: NSCity
    
    var dbModel: DBWeather {
        .init(self)
    }
}
