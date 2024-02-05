//
//  AppData.swift
//  CityWeather
//
//  Created by Michał Krupa on 02/02/2024.
//

import Foundation

struct AppData {
   
    private static let defaults = UserDefaults.standard
    
    static var unitSystem: UnitSystem {
        if let systemRaw: String = get(.unitSystem),
           let system = UnitSystem(rawValue: systemRaw) {
            return system
            
        } else {
            return .metric
        }
    }
    
    static func get<T>(_ key: AppDataKey) -> T? {
        defaults.value(forKey: key.rawValue) as? T
    }
    
    static func get<T>(_ key: String) -> T? {
        defaults.value(forKey: key) as? T
    }
    
    static func set(_ data: Any?, for key: AppDataKey) {
        defaults.set(data, forKey: key.rawValue)
    }
    
    static func set(_ data: Any?, for key: String) {
        defaults.set(data, forKey: key)
    }
}
