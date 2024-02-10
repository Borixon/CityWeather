//
//  DBWeatherStamp.swift
//  CityWeather
//
//  Created by Michał Krupa on 08/02/2024.
//

import RealmSwift
import Foundation

@objcMembers final class DBWeatherDataPoint: Object {
    
    dynamic var id: TimeInterval                = 0
    dynamic var time: TimeInterval              = 0
    dynamic var timeReadable: String            = ""
    dynamic var cloudCoverage: Int8             = 0
    dynamic var precipation: Float              = 0
    dynamic var visibility: Int16               = 0
    dynamic var weatherDescription: String?     = ""
    dynamic var weatherIcon: String?            = ""
    dynamic var temperature: Float              = 0
    dynamic var tempSensed: Float               = 0
    dynamic var tempMin: Float                  = 0
    dynamic var tempMax: Float                  = 0
    dynamic var pressure: Int16                 = 0
    
    override init() { }
    
    init(_ data: NSWeatherStamp) {
        self.time = data.time
        self.timeReadable = data.timeReadable
        self.cloudCoverage = data.clouds.coverage
        self.precipation = data.precipation
        self.visibility = data.visibility
        self.weatherDescription = data.weather.first?.description
        self.weatherIcon = data.weather.first?.icon
        self.temperature = data.athmosphere.temperature
        self.tempSensed = data.athmosphere.tempSensed
        self.tempMax = data.athmosphere.tempMax
        self.tempMin = data.athmosphere.tempMin
        self.pressure = data.athmosphere.pressure
    }
}
