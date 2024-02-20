//
//  Conditions.swift
//  PixiForecast
//
//  Created by Michał Krupa on 15/02/2024.
//

import Foundation

enum ConditionsGroup: Codable {
    
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case thunderstorm
    case rain
    case snow
    case mist
 
    private enum CodingKeys: String, CodingKey {
        case clearSky = "clear sky"
        case fewClouds = "few clouds"
        case scatteredClouds = "scattered clouds"
        case brokenClouds = "broken clouds"
        case showerRain = " shower rain"
        case thunderstorm
        case rain
        case snow
        case mist
    }
}
