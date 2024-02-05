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
}

extension NSCityWeather {
    
    var daysData: Array<DayShortData> {
        let groupedData = Dictionary(
            grouping: list,
            by: { Calendar.current.startOfDay(
                for: Date(timeIntervalSince1970: $0.time))
            })
        
        let mapped: [DayShortData?] = groupedData.keys.map({
            if let time = groupedData[$0]?.map({ $0.time }).first,
               let atmo = groupedData[$0]?.map({ $0.athmosphere }),
               let min = atmo.map({ $0.tempMin }).min(),
               let max = atmo.map({ $0.tempMax }).max() {
                let pressures = atmo.map({ $0.pressure })
                let averagePressure: Double = Double(pressures.reduce(0, +)) / Double(pressures.count)
                
                return DayShortData(
                    id: time,
                    time: time,
                    day: time.dayText(),
                    date: time.dateText(),
                    tempMin: min,
                    tempMax: max, 
                    pressure: Int16(averagePressure))
                
            } else {
                return nil
            }
        })

        return Array(mapped
            .compactMap { $0 }
            .sorted(by: { $0.time < $1.time })
            .prefix(5))
    }
    
    var headerData: CityHeaderData {
        print(self)
        return .init(
            city: city.name,
            castDescription: list.first?.weather.first?.description,
            temperature: list.first?.athmosphere.temperature,
            sensedTemperature: list.first?.athmosphere.tempSensed,
            sunrise: city.sunrise,
            sunset: city.sunset)
    }
}
