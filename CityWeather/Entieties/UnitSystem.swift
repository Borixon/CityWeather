//
//  UnitSystem.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import Foundation

enum UnitSystem: String {
    case standard, metric, imperial
    
    var tempUnit: String {
        switch self {
        case .standard:
            "K"
        case .metric:
            "ºC"
        case .imperial:
            "ºF"
        }
    }
    
    var pressureUnit: String {
        switch self {
        case .standard:
            "hPa"
        case .metric:
            "hPa"
        case .imperial:
            "PSI"
        }
    }
}
